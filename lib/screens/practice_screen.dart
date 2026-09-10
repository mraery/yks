import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_lessons.dart';
import '../models/lesson_models.dart';
import '../providers/game_provider.dart';
import '../widgets/duo_button.dart';
import '../widgets/out_of_hearts_dialog.dart';
import 'flashcards_screen.dart';
import 'quiz_screen.dart';

class PracticeScreen extends ConsumerWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Pratik & Can Kazan',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Can Durum Kartı (Duolingo Stili)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDFE0),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFFFB4B6), width: 2),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFFFF4B4B),
                    size: 54,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mevcut Can: ${profile.hearts} / 5',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFD32F2F),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.hearts < 5
                              ? 'Pratik testini tamamlayarak +1 Can kazanabilirsin!'
                              : 'Canların tamamen dolu! Bilgilerini taze tutmak için pratik yap.',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF4B4B4B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Hızlı Pratik Modu Kartı
            _buildActionCard(
              context: context,
              title: 'Hızlı Soru Pratiği',
              subtitle: 'TYT Türkçe ve Tarih karışık mini soru seti çöz, hem XP hem de +1 Can kazan.',
              icon: Icons.flash_on_rounded,
              iconColor: const Color(0xFFFF9600),
              buttonText: 'PRATİĞE BAŞLA',
              buttonColor: DuoButtonColor.green,
              onTap: () {
                final allQuizQuestions = mockUnits
                    .expand((u) => u.lessons)
                    .expand((l) => l.questions)
                    .where((q) => q.type != QuestionType.conceptCard)
                    .toList();
                allQuizQuestions.shuffle();
                final practiceQuestions = allQuizQuestions.take(3).toList();

                if (profile.hearts <= 0 && !profile.isPremium) {
                  OutOfHeartsDialog.show(context, ref);
                  return;
                }

                // Karışık pratik dersi oluştur
                final practiceLesson = Lesson(
                  id: 'practice_mixed_${DateTime.now().millisecondsSinceEpoch}',
                  title: 'Hızlı Pratik',
                  description: 'Can kazanma ve genel tekrar modu',
                  xpReward: 25,
                  gemReward: 10,
                  questions: practiceQuestions,
                );

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(lesson: practiceLesson),
                  ),
                ).then((_) {
                  // Pratik sonrası can tazele
                  ref.read(userProfileProvider.notifier).gainHeart();
                });
              },
            ),

            const SizedBox(height: 16),

            // Kartlarla Pekiştir Modu (Flaş Kartlar)
            _buildActionCard(
              context: context,
              title: 'Kartlarla Pekiştir 🎴',
              subtitle: 'Kavram kartını çevir, anlamını öğren. Sağa atarak öğrendim de, sola atarak tekrar listene ekle!',
              icon: Icons.style_rounded,
              iconColor: const Color(0xFF7C3AED),
              buttonText: 'KARTLARI ÇEVİR',
              buttonColor: DuoButtonColor.purple,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const FlashcardsScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Hata Defteri Modu
            _buildActionCard(
              context: context,
              title: 'Hata Defteri & Tekrar',
              subtitle: 'Önceki testlerde yanlış yaptığın veya boş bıraktığın sorular burada toplanır.',
              icon: Icons.auto_stories_rounded,
              iconColor: const Color(0xFF1CB0F6),
              buttonText: 'HATALARI TEKRAR ET',
              buttonColor: DuoButtonColor.blue,
              onTap: () {
                if (profile.hearts <= 0 && !profile.isPremium) {
                  OutOfHeartsDialog.show(context, ref);
                  return;
                }

                final allQuestions = mockUnits
                    .expand((u) => u.lessons)
                    .expand((l) => l.questions)
                    .where((q) => q.type != QuestionType.conceptCard)
                    .toList();
                final mistakeQuestions = allQuestions.take(2).toList();

                final mistakeLesson = Lesson(
                  id: 'practice_mistakes',
                  title: 'Hata Defteri',
                  description: 'Daha önce takıldığın kavramları pekiştir',
                  xpReward: 20,
                  gemReward: 8,
                  questions: mistakeQuestions,
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(lesson: mistakeLesson),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Günün YKS Hap Bilgisi
            const Text(
              'GÜNÜN YKS HAP BİLGİSİ 💡',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 14,
                letterSpacing: 0.8,
                color: Color(0xFF777777),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb_rounded, color: Color(0xFFFFC800), size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Amasya Genelgesi Püf Noktası',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '"Milletin bağımsızlığını yine milletin azim ve kararı kurtaracaktır" maddesi hem yöntemi belirtir hem de ilk kez ulusal egemenlikten üstü kapalı bahseder.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF4B4B4B), height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required String buttonText,
    required DuoButtonColor buttonColor,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF4B4B4B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 13, color: Color(0xFF777777)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DuoButton(
            text: buttonText,
            color: buttonColor,
            height: 46,
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
