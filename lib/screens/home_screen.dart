import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lesson_models.dart';
import '../models/exam_config.dart';
import '../providers/game_provider.dart';
import '../providers/exam_provider.dart';
import '../widgets/parrot_mascot_widget.dart';
import '../widgets/parrot_seed_node.dart';
import '../widgets/stats_bar.dart';
import '../widgets/unit_guidebook_sheet.dart';
import '../widgets/peanut_ad_break_dialog.dart';
import '../widgets/out_of_hearts_dialog.dart';
import 'quiz_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String? _selectedExam; // 'TYT', 'AYT', 'Sayısal', 'Sözel', 'Genel Yetenek' vs.
  String _selectedSubject = 'Tümü';

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final activeExam = ref.watch(examConfigProvider);
    final allUnits = ref.watch(currentUnitsProvider);

    final currentSection = (_selectedExam != null && activeExam.sections.contains(_selectedExam))
        ? _selectedExam!
        : activeExam.sections.first;

    final examUnits = allUnits.where((u) {
      if (activeExam.franchise == ExamFranchise.yks) {
        return currentSection == 'TYT' ? !u.subject.startsWith('AYT') : u.subject.startsWith('AYT');
      } else if (activeExam.franchise == ExamFranchise.dgs) {
        return currentSection == 'Sayısal'
            ? (u.subject.contains('Matematik') || u.subject.contains('Problem') || u.subject.contains('Geometri'))
            : (u.subject.contains('Sözel') || u.subject.contains('Paragraf') || u.subject.contains('Mantık'));
      } else if (activeExam.franchise == ExamFranchise.lgs) {
        return currentSection == 'Sayısal'
            ? (u.subject.contains('Matematik') || u.subject.contains('Fen'))
            : (u.subject.contains('Türkçe') || u.subject.contains('İnkılap') || u.subject.contains('Din') || u.subject.contains('İngilizce'));
      } else {
        return currentSection == 'Genel Yetenek'
            ? (u.subject.contains('Türkçe') || u.subject.contains('Matematik'))
            : (u.subject.contains('Tarih') || u.subject.contains('Coğrafya') || u.subject.contains('Vatandaşlık') || u.subject.contains('Güncel'));
      }
    }).toList();

    final filteredUnits = _selectedSubject == 'Tümü'
        ? examUnits
        : examUnits.where((u) => u.subject == _selectedSubject).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5), // Sıcak vanilya / doğal zemin
      appBar: const StatsBar(),
      body: Stack(
        children: [
          Column(
            children: [
              // Sınav Bölümü Seçim Segmenti (TYT/AYT, Sayısal/Sözel vb.)
              _buildExamSwitcher(activeExam, allUnits, currentSection),

              // Branş Filtreleme Çubuğu (Tatlı Kapsüller)
              _buildSubjectFilterBar(activeExam),

              // Zeki Paşa'nın Yemlik & Koçluk Kartı
              _buildParrotCoachCard(userProfile, activeExam),

              // Sevimli Tohum Yolu Haritası
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 64, top: 4),
                  itemCount: filteredUnits.length,
                  itemBuilder: (context, unitIndex) {
                    final unit = filteredUnits[unitIndex];
                    return _buildUnitSection(context, unitIndex, unit, userProfile);
                  },
                ),
              ),
            ],
          ),
          // Sağ Alt: Quest Sürüm Rozeti
          Positioned(
            bottom: 12,
            right: 12,
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.18),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF22C55E),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${activeExam.title} • Alpha v0.1.0',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamSwitcher(ExamConfig activeExam, List<LearningUnit> allUnits, String currentSection) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFECE7E1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2DBD0), width: 1),
      ),
      child: Row(
        children: activeExam.sections.map((sec) {
          final count = allUnits.where((u) {
            if (activeExam.franchise == ExamFranchise.yks) {
              return sec == 'TYT' ? !u.subject.startsWith('AYT') : u.subject.startsWith('AYT');
            } else if (activeExam.franchise == ExamFranchise.dgs) {
              return sec == 'Sayısal'
                  ? (u.subject.contains('Matematik') || u.subject.contains('Problem') || u.subject.contains('Geometri'))
                  : (u.subject.contains('Sözel') || u.subject.contains('Paragraf') || u.subject.contains('Mantık'));
            } else if (activeExam.franchise == ExamFranchise.lgs) {
              return sec == 'Sayısal'
                  ? (u.subject.contains('Matematik') || u.subject.contains('Fen'))
                  : (u.subject.contains('Türkçe') || u.subject.contains('İnkılap') || u.subject.contains('Din') || u.subject.contains('İngilizce'));
            } else {
              return sec == 'Genel Yetenek'
                  ? (u.subject.contains('Türkçe') || u.subject.contains('Matematik'))
                  : (u.subject.contains('Tarih') || u.subject.contains('Coğrafya') || u.subject.contains('Vatandaşlık') || u.subject.contains('Güncel'));
            }
          }).length;

          final isSelected = currentSection == sec;

          return Expanded(
            child: _buildExamTabButton(
              title: sec,
              subTitle: '$count Ünite',
              exam: sec,
              icon: (sec.contains('Sayısal') || sec == 'TYT' || sec == 'Genel Yetenek') ? '🎯' : '🚀',
              activeColor: (sec.contains('Sayısal') || sec == 'TYT' || sec == 'Genel Yetenek') ? activeExam.primaryColor : activeExam.secondaryColor,
              isSelected: isSelected,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExamTabButton({
    required String title,
    required String subTitle,
    required String exam,
    required String icon,
    required Color activeColor,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        if (_selectedExam != exam) {
          setState(() {
            _selectedExam = exam;
            _selectedSubject = 'Tümü';
          });
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: isSelected ? activeColor : const Color(0xFF78716C),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? activeColor.withOpacity(0.12)
                    : const Color(0xFFDFD8CF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                subTitle,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? activeColor : const Color(0xFF8A8279),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectFilterBar(ExamConfig activeExam) {
    final currentSubjects = activeExam.subjects;

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF1ECE4), width: 1.5)),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: currentSubjects.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = currentSubjects[index];
          final name = item['name']!;
          final icon = item['icon']!;
          final isSelected = _selectedSubject == name;

          final activeColor = activeExam.primaryColor;

          return InkWell(
            onTap: () {
              setState(() {
                _selectedSubject = name;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              decoration: BoxDecoration(
                color: isSelected ? activeColor : const Color(0xFFFBF8F3),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: activeColor.withOpacity(0.26),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
                border: Border.all(
                  color: isSelected ? activeColor : const Color(0xFFEADBCE),
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(icon, style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 5),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? Colors.white : const Color(0xFF4B382A),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildParrotCoachCard(UserProfile profile, ExamConfig activeExam) {
    final completedCount = profile.completedLessonIds.length;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1ECE4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD97706).withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ParrotMascotWidget(
            size: 64,
            mood: ParrotMood.idle,
            hasCrown: profile.isPremium,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      'Zeki Paşa',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF292524),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: profile.isPremium
                            ? const LinearGradient(
                                colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
                              )
                            : LinearGradient(
                                colors: [activeExam.primaryColor, activeExam.secondaryColor],
                              ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        profile.isPremium ? 'SUPER PREMİUM 👑' : '${activeExam.shortTitle} KOÇU 🎓',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  profile.isPremium
                      ? 'Sınırsız canınla çalışıyorsun! Yanlış yapmaktan korkma, hedefe odaklan. 👑'
                      : activeExam.mascotGreeting,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF78716C),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('🌱 ', style: TextStyle(fontSize: 12)),
                    Text(
                      '$completedCount Konu Tamamlandı',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF059669),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitSection(
    BuildContext context,
    int unitIndex,
    LearningUnit unit,
    UserProfile profile,
  ) {
    final unitColor = Color(unit.colorHex);

    return Column(
      children: [
        // Ünite Başlık Kartı (Sıcak & Canlı)
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [unitColor, Color.alphaBlend(Colors.black38, unitColor)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: unitColor.withOpacity(0.32),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'ÜNİTE ${unit.unitNumber} • ${unit.subject.toUpperCase()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 10.5,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      unit.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${unit.lessons.length} Konu • Başarıya İlerle 🌻',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Cep Rehberi Butonu
              InkWell(
                onTap: () => UnitGuidebookSheet.show(context, unit),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.menu_book_rounded, color: unitColor, size: 22),
                      const SizedBox(height: 2),
                      Text(
                        'REHBER',
                        style: TextStyle(
                          color: unitColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 10.5,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Tatlı Sarmaşık & Tohum Yolu (Papağan Yemleri)
        ...List.generate(unit.lessons.length, (lessonIndex) {
          final lesson = unit.lessons[lessonIndex];
          final score = profile.lessonScores[lesson.id];
          final isCompleted = profile.completedLessonIds.contains(lesson.id);

          bool isUnlocked = false;
          double? prevScore;
          if (profile.isCheatUnlocked || lessonIndex == 0) {
            isUnlocked = true;
          } else {
            final prevLesson = unit.lessons[lessonIndex - 1];
            prevScore = profile.lessonScores[prevLesson.id];
            isUnlocked = profile.completedLessonIds.contains(prevLesson.id) &&
                (prevScore != null && prevScore >= 50.0);
          }

          // Kıvrımlı yol dağılımı: 0 -> 0, 1 -> +38, 2 -> 0, 3 -> -38
          final offsets = [0.0, 38.0, 0.0, -38.0];
          final xOffset = lesson.isUnitExam ? 0.0 : offsets[lessonIndex % offsets.length];

          return Column(
            children: [
              // Basamaklar Arası Bağlantı Yolu (Duolingo Stili Stepping Trail)
              if (lessonIndex > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    children: List.generate(3, (dotIndex) {
                      final dotSize = dotIndex == 1 ? 7.0 : 5.0;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: Container(
                          width: dotSize,
                          height: dotSize,
                          decoration: BoxDecoration(
                            color: isUnlocked
                                ? unitColor.withOpacity(0.40 + (dotIndex * 0.15))
                                : const Color(0xFFCBD5E1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

              // 3D Öğrenme Basamağı
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Transform.translate(
                  offset: Offset(xOffset, 0),
                  child: ParrotSeedNode(
                    lesson: lesson,
                    seedIndex: lessonIndex + 1,
                    baseColor: unitColor,
                    score: score,
                    isCompleted: isCompleted,
                    isUnlocked: isUnlocked,
                    onTap: () {
                      if (!isUnlocked) {
                        final message = (prevScore != null && prevScore < 50.0)
                            ? 'Bu dersi açmak için önceki dersten en az %50 almalısın! 🎯 (Önceki: %${prevScore.toInt()})'
                            : 'Bu dersi açmak için önce önceki dersi tamamlamalısın! 🔒';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Text('🔒 ', style: TextStyle(fontSize: 16)),
                                SizedBox(width: 8),
                                Expanded(child: Text(message)),
                              ],
                            ),
                            duration: const Duration(seconds: 3),
                            backgroundColor: const Color(0xFF292524),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        );
                        return;
                      }

                      // Can bitince konuya girmeyi engelle!
                      if (profile.hearts <= 0 && !profile.isPremium) {
                        OutOfHeartsDialog.show(context, ref);
                        return;
                      }

                      _showSeedStartSheet(context, lesson, unitColor, score, isCompleted);
                    },
                  ),
                ),
              ),
              // Fıstık Reklam Molası (Her 3 derste bir)
              if ((lessonIndex + 1) % 3 == 0 && lessonIndex < unit.lessons.length - 1)
                _buildPeanutCheckpoint(context, ref, profile),
            ],
          );
        }),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPeanutCheckpoint(BuildContext context, WidgetRef ref, UserProfile profile) {
    final isPremium = profile.isPremium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          if (isPremium) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.workspace_premium_rounded, color: Color(0xFFFDE68A)),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '👑 Premium Üyesin! Reklamlar senin için tamamen kapalı, afiyet olsun! 🥜✨',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF7C3AED),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            );
          } else {
            PeanutAdBreakDialog.showIfEligible(context, ref);
          }
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isPremium
                  ? [const Color(0xFF8B5CF6), const Color(0xFF6D28D9)]
                  : [const Color(0xFFFEF3C7), const Color(0xFFFDE68A)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isPremium ? const Color(0xFFA78BFA) : const Color(0xFFF59E0B),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: (isPremium ? const Color(0xFF7C3AED) : const Color(0xFFF59E0B)).withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(isPremium ? '👑' : '🥜', style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                isPremium ? 'PREMİUM GEÇİŞ: REKLAMSIZ ⚡' : 'FISTIK REKLAM MOLASI (+5 💎)',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                  color: isPremium ? Colors.white : const Color(0xFF92400E),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 6),
              Text(isPremium ? '✨' : '🥜', style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  void _showSeedStartSheet(
    BuildContext context,
    Lesson lesson,
    Color unitColor,
    double? score,
    bool isCompleted,
  ) {
    final isExam = lesson.isUnitExam;
    Color themeColor;
    if (score != null) {
      if (score >= 100.0) {
        themeColor = const Color(0xFFF59E0B);
      } else if (score >= 50.0) {
        themeColor = const Color(0xFF10B981);
      } else {
        themeColor = const Color(0xFFF43F5E);
      }
    } else {
      themeColor = isExam ? const Color(0xFFEA580C) : unitColor;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SafeArea(
        top: false,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    isExam ? '🌻' : (score != null && score >= 100.0 ? '⭐' : '🌾'),
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isExam) ...[
                        const Text(
                          '🌻 BÜYÜK AYÇİÇEĞİ ZİYAFETİ (FİNAL)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFEA580C),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 2),
                      ],
                      Text(
                        lesson.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF292524),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        lesson.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF78716C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (score != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: themeColor.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      score >= 100.0
                          ? Icons.stars_rounded
                          : (score >= 50.0
                              ? Icons.check_circle_outline_rounded
                              : Icons.warning_amber_rounded),
                      color: themeColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        score >= 100.0
                            ? 'Mükemmel Başarı: %100 Altın Rozet! 🌟'
                            : (score >= 50.0
                                ? 'Önceki Başarı: %${score.toInt()} (Tamamlandı)'
                                : 'Önceki Başarı: %${score.toInt()} (Sonraki ders için en az %50 almalısın!)'),
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: themeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF8F5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1ECE4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSheetReward(Icons.bolt_rounded, '+${lesson.xpReward} XP', const Color(0xFFEA580C)),
                  _buildSheetReward(Icons.diamond_rounded, '+${lesson.gemReward} 💎', const Color(0xFF0284C7)),
                  _buildSheetReward(
                    isExam ? Icons.military_tech_rounded : Icons.quiz_rounded,
                    isExam ? 'Büyük Sınav' : '${lesson.questions.length} Adım',
                    const Color(0xFF10B981),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
              ),
              onPressed: () {
                final currentHearts = ref.read(userProfileProvider).hearts;
                final isPrem = ref.read(userProfileProvider).isPremium;
                if (currentHearts <= 0 && !isPrem) {
                  Navigator.of(ctx).pop();
                  OutOfHeartsDialog.show(context, ref);
                  return;
                }
                Navigator.of(ctx).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(lesson: lesson),
                  ),
                );
              },
              child: Text(
                score != null
                    ? (score < 50.0 ? 'TEKRAR ÇALIŞ (%50 İÇİN)' : (score >= 100.0 ? 'TEKRAR ÇALIŞ' : 'PUANI YÜKSELT'))
                    : (isExam ? 'BÜYÜK ŞÖLENİ BAŞLAT! 🌻👑' : 'DERSE BAŞLA! 🦜✨'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);
  }

  Widget _buildSheetReward(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }
}
