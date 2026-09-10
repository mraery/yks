import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lesson_models.dart';
import '../providers/game_provider.dart';
import '../providers/quiz_provider.dart';
import '../services/sound_service.dart';
import '../widgets/concept_card_widget.dart';
import '../widgets/duo_button.dart';
import '../widgets/fill_in_blank_widget.dart';
import '../widgets/matching_game_widget.dart';
import '../widgets/multiple_choice_widget.dart';
import '../widgets/parrot_mascot_widget.dart';
import '../widgets/out_of_hearts_dialog.dart';
import '../widgets/peanut_ad_break_dialog.dart';
import '../widgets/true_false_widget.dart';
import 'lesson_complete_screen.dart';

class QuizScreen extends ConsumerWidget {
  final Lesson lesson;

  const QuizScreen({super.key, required this.lesson});

  static const _correctQuotes = [
    'Helal olsun! YKS\'de +1 net cepte! 🎯',
    'Tebrikler şampiyon! Aynen böyle devam! 🦜🔥',
    'Harikasın! Bu soru tam sınav tarzıydı! 💡',
    'Müthiş odaklanma! Zeki Paşa gurur duyuyor! 🌟',
    'Taktik tıkır tıkır işliyor, netler artıyor! 🚀',
  ];

  static const _incorrectQuotes = [
    'Canın sağ olsun! Yanlış yapmadan doğrusu öğrenilmez. 💪🦜',
    'Önemli olan mantığını kapmak. Açıklamayı iyi oku! 💡',
    'Moralleri bozmuyoruz! Sınavda gelse kaçardı, şimdi kaptın! 🎯',
    'Pes etmek yok! Zeki Paşa arkanda, devam ediyoruz! 🛡️',
    'Bir dahakine affetmezsin! Odaklanmaya devam et! 🔥',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider(lesson));
    final quizNotifier = ref.read(quizProvider(lesson).notifier);
    final userProfile = ref.watch(userProfileProvider);

    // Sınav bittiğinde sonuç ekranına geçiş ve ses efektleri
    ref.listen<QuizState>(quizProvider(lesson), (previous, next) {
      if (next.isQuizComplete && !(previous?.isQuizComplete ?? false)) {
        if (next.isPassed) {
          SoundService.playLessonPass();
        } else {
          SoundService.playLessonFail();
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LessonCompleteScreen(
              lesson: lesson,
              correctCount: next.correctCount,
              totalQuestions: next.totalTestQuestions,
            ),
          ),
        );
      } else if (next.isAnswerChecked && !(previous?.isAnswerChecked ?? false)) {
        if (next.isAnswerCorrect) {
          SoundService.playCorrect();
        } else {
          SoundService.playIncorrect();
        }
      }
    });

    // Başlangıçta can 0 ise derse hiç başlatma, doğrudan can bitti diyaloğunu aç ve güvenle ana sayfaya dön
    if (userProfile.hearts <= 0 && !userProfile.isPremium) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          _showOutOfHeartsDialog(context, ref);
        }
      });
    }

    // Kalp 0'a düştüğünde (eşleştirme oyunu veya normal soru) oyun sonu diyaloğunu aç
    ref.listen<int>(userProfileProvider.select((p) => p.hearts), (previous, next) {
      final isPrem = ref.read(userProfileProvider).isPremium;
      if (!isPrem && next <= 0 && (previous ?? 5) > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            _showOutOfHeartsDialog(context, ref);
          }
        });
      }
    });

    final currentQuestion = quizState.currentQuestion;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _showExitConfirm(context);
        if (shouldExit == true && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Üst İlerleme ve Can Barı
              _buildTopBar(
                context,
                quizState,
                userProfile.hearts,
                isCheatUnlocked: userProfile.isCheatUnlocked,
                isPremium: userProfile.isPremium,
                onCheatAutoSolve: quizNotifier.autoSolveCurrentQuestion,
              ),

              // Soru İçerik Alanı
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: KeyedSubtree(
                    key: ValueKey(currentQuestion.id),
                    child: _buildQuestionContent(
                      currentQuestion,
                      quizState,
                      quizNotifier,
                    ),
                  ),
                ),
              ),

              // Alt Kontrol / Geri Bildirim Barı (Duolingo Stili)
              _buildBottomBar(context, quizState, quizNotifier, ref, userProfile.isCheatUnlocked),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    QuizState state,
    int hearts, {
    bool isCheatUnlocked = false,
    bool isPremium = false,
    VoidCallback? onCheatAutoSolve,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Çıkış Butonu
          IconButton(
            icon: const Icon(Icons.close_rounded, color: Color(0xFFAFAFAF), size: 28),
            onPressed: () async {
              final shouldExit = await _showExitConfirm(context);
              if (shouldExit == true && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
          const SizedBox(width: 8),

          // İlerleme Çubuğu
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 14,
                child: LinearProgressIndicator(
                  value: state.progress,
                  backgroundColor: const Color(0xFFE5E5E5),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Can Göstergesi
          Row(
            children: [
              const Icon(Icons.favorite_rounded, color: Color(0xFFFF4B4B), size: 24),
              const SizedBox(width: 4),
              Text(
                isPremium ? '♾️' : '$hearts',
                style: const TextStyle(
                  color: Color(0xFFFF4B4B),
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
              if (isPremium) ...[
                const SizedBox(width: 4),
                const Icon(Icons.workspace_premium_rounded, color: Color(0xFFF59E0B), size: 18),
              ],
            ],
          ),

          // ⚡ Kagan Özel Hile Butonu (Top Bar)
          if (isCheatUnlocked) ...[
            const SizedBox(width: 10),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onCheatAutoSolve,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7C3AED).withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bolt_rounded, color: Colors.amber, size: 18),
                      SizedBox(width: 2),
                      Text(
                        'OTO-ÇÖZ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuestionContent(
    Question question,
    QuizState state,
    QuizNotifier notifier,
  ) {
    switch (question.type) {
      case QuestionType.conceptCard:
        return ConceptCardWidget(question: question);
      case QuestionType.multipleChoice:
        return MultipleChoiceWidget(
          question: question,
          selectedIndex: state.selectedOptionIndex,
          isChecked: state.isAnswerChecked,
          onSelect: notifier.selectOption,
        );
      case QuestionType.matching:
        return MatchingGameWidget(
          question: question,
          matchedPairs: state.matchedPairs,
          selectedLeft: state.selectedLeft,
          selectedRight: state.selectedRight,
          mismatchedLeft: state.mismatchedLeft,
          mismatchedRight: state.mismatchedRight,
          isChecked: state.isAnswerChecked,
          onSelectLeft: notifier.selectLeft,
          onSelectRight: notifier.selectRight,
        );
      case QuestionType.trueFalse:
        return TrueFalseWidget(
          question: question,
          selectedValue: state.selectedBool,
          isChecked: state.isAnswerChecked,
          onSelect: notifier.selectBool,
        );
      case QuestionType.fillInTheBlank:
        return FillInBlankWidget(
          question: question,
          selectedAnswer: state.selectedBlankAnswer,
          isChecked: state.isAnswerChecked,
          onSelect: notifier.selectBlankAnswer,
        );
    }
  }

  Widget _buildBottomBar(
    BuildContext context,
    QuizState state,
    QuizNotifier notifier,
    WidgetRef ref, [
    bool isCheatUnlocked = false,
  ]) {
    // 1. Konu Anlatım Kartı İçin Alt Bar
    if (state.currentQuestion.type == QuestionType.conceptCard) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E5E5), width: 2)),
        ),
        child: DuoButton(
          text: 'ÖĞRENDİM, TEST ET! 🚀',
          color: DuoButtonColor.green,
          height: 52,
          onPressed: notifier.advanceConceptCard,
        ),
      );
    }

    if (!state.isAnswerChecked) {
      // Henüz Kontrol Edilmedi
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E5E5), width: 2)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ⚡ HİLE: Doğru İşaretle Butonu (Kullanıcı hiçbir şık seçmese bile çalışır)
            if (isCheatUnlocked) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED), // Mor
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.bolt_rounded, color: Colors.amber, size: 22),
                  label: const Text(
                    '⚡ OTO-DOĞRU İŞARETLE (HİLE)',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                  onPressed: notifier.autoSolveCurrentQuestion,
                ),
              ),
              const SizedBox(height: 10),
            ],
            DuoButton(
              text: 'KONTROL ET',
              color: DuoButtonColor.green,
              height: 52,
              onPressed: state.canCheckAnswer ? notifier.checkAnswer : null,
            ),
          ],
        ),
      );
    }

    // Cevap kontrol edildi (Doğru veya Yanlış Paneli)
    final isCorrect = state.isAnswerCorrect;

    final quotes = isCorrect ? _correctQuotes : _incorrectQuotes;
    final int quoteIndex = (state.currentQuestion.id.hashCode.abs() + state.currentIndex) % quotes.length;
    final mascotQuote = quotes[quoteIndex];

    final bgColor = isCorrect
        ? const Color(0xFFF0FDF4)
        : const Color(0xFFFEF2F2);
    final primaryColor = isCorrect
        ? const Color(0xFF16A34A)
        : const Color(0xFFDC2626);
    final borderColor = isCorrect
        ? const Color(0xFFBBF7D0)
        : const Color(0xFFFECACA);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: borderColor, width: 1.5)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Zeki Paşa Motivasyon Konuşması
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                ParrotMascotWidget(
                  size: 46,
                  mood: isCorrect ? ParrotMood.happy : ParrotMood.oops,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            isCorrect ? 'Zeki Paşa Sevinçli 🎉' : 'Zeki Paşa Yanında 💪',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: primaryColor,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        mascotQuote,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Doğru / Yanlış Açıklama
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCorrect ? Icons.check_rounded : Icons.close_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCorrect ? 'Harika Çözüm!' : 'Doğru Bilgi & Açıklama:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      state.currentQuestion.explanation,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isCorrect ? const Color(0xFF166534) : const Color(0xFF991B1B),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          DuoButton(
            text: isCorrect ? 'DEVAM ET' : 'ANLADIM, DEVAM ET',
            color: isCorrect ? DuoButtonColor.green : DuoButtonColor.red,
            height: 50,
            onPressed: () async {
              final currentHearts = ref.read(userProfileProvider).hearts;
              if (currentHearts <= 0) {
                _showOutOfHeartsDialog(context, ref);
                return;
              }

              // Her 10 soruda bir reklam molası kontrolü
              final shouldShowAd = ref
                  .read(userProfileProvider.notifier)
                  .incrementQuestionsAnswered();
              if (shouldShowAd && context.mounted) {
                await PeanutAdBreakDialog.showIfEligible(context, ref,
                    isTenQuestionsBreak: true);
              }

              if (context.mounted) {
                notifier.nextQuestion();
              }
            },
          ),
        ],
      ),
    );
  }

  static bool _isHandlingHearts = false;

  void _showOutOfHeartsDialog(BuildContext context, WidgetRef ref) async {
    if (_isHandlingHearts) return;
    _isHandlingHearts = true;

    final refilled = await OutOfHeartsDialog.show(context, ref);
    _isHandlingHearts = false;

    if (!refilled && context.mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  Future<bool?> _showExitConfirm(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Ayrılmak istiyor musun?',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
          'Şimdi çıkarsan bu dersteki ilerlemen ve kazanacağın puanlar kaydedilmeyecek.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('DEVAM ET', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4B4B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('ÇIK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
