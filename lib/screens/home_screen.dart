import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_lessons.dart';
import '../models/lesson_models.dart';
import '../providers/game_provider.dart';
import '../widgets/parrot_mascot_widget.dart';
import '../widgets/stats_bar.dart';
import '../widgets/unit_guidebook_sheet.dart';
import 'quiz_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _selectedSubject = 'Tümü';

  final List<Map<String, String>> _subjects = const [
    {'name': 'Tümü', 'icon': '🌟'},
    {'name': 'TYT Türkçe', 'icon': '📚'},
    {'name': 'TYT Matematik', 'icon': '📐'},
    {'name': 'TYT Tarih', 'icon': '🏛️'},
    {'name': 'TYT Coğrafya', 'icon': '🌍'},
    {'name': 'TYT Biyoloji', 'icon': '🧬'},
  ];

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);

    final filteredUnits = _selectedSubject == 'Tümü'
        ? mockUnits
        : mockUnits.where((u) => u.subject == _selectedSubject).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const StatsBar(),
      body: Column(
        children: [
          // Branş Filtreleme Çubuğu (YKS Konu Seçici)
          _buildSubjectFilterBar(),

          // Renkli Papağan Zeki Paşa Karşılama Kartı
          _buildParrotGreeting(),

          // Üniteler ve Soru Yolu
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 40, top: 8),
              itemCount: filteredUnits.length,
              itemBuilder: (context, unitIndex) {
                final unit = filteredUnits[unitIndex];
                return _buildUnitSection(context, unitIndex, unit, userProfile);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParrotGreeting() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF7ED), Color(0xFFEFF6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFED7AA), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF97316).withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const ParrotMascotWidget(size: 64, mood: ParrotMood.idle),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      'Zeki Paşa 🦜',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFC2410C),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEA580C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'YKS Koçun',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                const Text(
                  'Her 3-4 soruda bir altın taktiği yakalamayı unutma! Bugün hedefin tam odaklanmak.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectFilterBar() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1.5)),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _subjects.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = _subjects[index];
          final name = item['name']!;
          final icon = item['icon']!;
          final isSelected = _selectedSubject == name;

          return InkWell(
            onTap: () {
              setState(() {
                _selectedSubject = name;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1CB0F6) : const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFF1899D6) : const Color(0xFFE5E5E5),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(icon, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? Colors.white : const Color(0xFF4B4B4B),
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

  Widget _buildUnitSection(
    BuildContext context,
    int unitIndex,
    LearningUnit unit,
    UserProfile profile,
  ) {
    final unitColor = Color(unit.colorHex);

    return Column(
      children: [
        // Ünite Başlık Bandı (Duolingo Banner)
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: unitColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: unitColor.withOpacity(0.4),
                offset: const Offset(0, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ÜNİTE ${unit.unitNumber} • ${unit.subject.toUpperCase()}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      unit.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Cep Rehberi (📖) Butonu
              InkWell(
                onTap: () => UnitGuidebookSheet.show(context, unit),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withOpacity(0.35), width: 1.5),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'REHBER',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Duolingo Dairesel Yol Haritası (Wavy Path Nodes)
        ...List.generate(unit.lessons.length, (lessonIndex) {
          final lesson = unit.lessons[lessonIndex];
          final score = profile.lessonScores[lesson.id];
          final isCompleted = profile.completedLessonIds.contains(lesson.id);

          // Her ünitenin ilk dersi açık olsun; diğerleri sırayla açılsın
          bool isUnlocked = false;
          double? prevScore;
          if (lessonIndex == 0) {
            isUnlocked = true;
          } else {
            final prevLesson = unit.lessons[lessonIndex - 1];
            prevScore = profile.lessonScores[prevLesson.id];
            // Kural: Önceki ders en az %50 başarıyla tamamlanmış olmalı!
            isUnlocked = profile.completedLessonIds.contains(prevLesson.id) &&
                (prevScore != null && prevScore >= 50.0);
          }

          // Zig-zag kıvrım hesaplama: 0 -> center, 1 -> right, 2 -> center, 3 -> left
          final offsets = [0.0, 48.0, 0.0, -48.0];
          final xOffset = lesson.isUnitExam ? 0.0 : offsets[lessonIndex % offsets.length];

          return Column(
            children: [
              // Bağlantı İzi (Connecting Path Dots)
              if (lessonIndex > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (dotIndex) {
                      return Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isUnlocked
                              ? unitColor.withOpacity(0.35)
                              : const Color(0xFFE0E0E0),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Transform.translate(
                  offset: Offset(xOffset, 0),
                  child: _buildLessonNode(
                    context,
                    lesson,
                    unitColor,
                    score,
                    isCompleted,
                    isUnlocked,
                    prevScore,
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildLessonNode(
    BuildContext context,
    Lesson lesson,
    Color unitColor,
    double? score,
    bool isCompleted,
    bool isUnlocked,
    double? prevScore,
  ) {
    Color nodeColor;
    Color shadowColor;
    IconData nodeIcon;
    String? badgeText;
    Color badgeColor;
    final isExam = lesson.isUnitExam;

    if (score != null) {
      if (score >= 100.0) {
        // %100 BAŞARI -> SARI (GOLD)
        nodeColor = const Color(0xFFFFC800);
        shadowColor = const Color(0xFFD69E00);
        nodeIcon = isExam ? Icons.emoji_events_rounded : Icons.star_rounded;
        badgeText = '⭐ %100';
        badgeColor = const Color(0xFFFFC800);
      } else if (score >= 50.0) {
        // %50 - %99 BAŞARI -> TURUNCU (ORANGE)
        nodeColor = const Color(0xFFFF9600);
        shadowColor = const Color(0xFFD67E00);
        nodeIcon = isExam ? Icons.emoji_events_rounded : Icons.check_rounded;
        badgeText = '%${score.toInt()}';
        badgeColor = const Color(0xFFFF9600);
      } else {
        // %50 ALTI -> KIRMIZI (RED) - GEÇİLEMEDİ
        nodeColor = const Color(0xFFFF4B4B);
        shadowColor = const Color(0xFFD63030);
        nodeIcon = Icons.refresh_rounded;
        badgeText = '✗ %${score.toInt()}';
        badgeColor = const Color(0xFFFF4B4B);
      }
    } else if (isUnlocked) {
      if (isExam) {
        nodeColor = const Color(0xFFFF9600);
        shadowColor = const Color(0xFFD67E00);
        nodeIcon = Icons.emoji_events_rounded;
        badgeText = '👑 FİNAL';
        badgeColor = const Color(0xFFFF9600);
      } else {
        nodeColor = unitColor;
        shadowColor = Color.alphaBlend(Colors.black38, unitColor);
        nodeIcon = Icons.star_rounded;
        badgeText = 'BAŞLA';
        badgeColor = unitColor;
      }
    } else {
      nodeColor = const Color(0xFFE5E5E5);
      shadowColor = const Color(0xFFCECECE);
      nodeIcon = isExam ? Icons.emoji_events_rounded : Icons.lock_rounded;
      badgeText = null;
      badgeColor = const Color(0xFFAFAFAF);
    }

    return Column(
      children: [
        TactileLessonNode(
          lesson: lesson,
          nodeColor: nodeColor,
          shadowColor: shadowColor,
          icon: nodeIcon,
          isUnlocked: isUnlocked,
          isExam: isExam,
          badgeText: badgeText,
          badgeColor: badgeColor,
          onTap: () {
            if (!isUnlocked) {
              final message = (prevScore != null && prevScore < 50.0)
                  ? 'Bu derse geçebilmek için önceki dersten en az %50 başarı elde etmelisin! (Önceki Başarın: %${prevScore.toInt()})'
                  : 'Bu derse geçmek için önce önceki dersi tamamlamalısın!';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.lock_rounded, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(message)),
                    ],
                  ),
                  duration: const Duration(seconds: 3),
                  backgroundColor: const Color(0xFF333333),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
              return;
            }
            _showLessonStartSheet(context, lesson, unitColor, score, isCompleted);
          },
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 140,
          child: Text(
            lesson.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isExam ? 13.5 : 12.5,
              fontWeight: isExam ? FontWeight.w900 : FontWeight.w800,
              color: isExam
                  ? (isUnlocked ? const Color(0xFFD67E00) : const Color(0xFFAFAFAF))
                  : (isUnlocked ? const Color(0xFF4B4B4B) : const Color(0xFFAFAFAF)),
            ),
          ),
        ),
      ],
    );
  }

  void _showLessonStartSheet(
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
        themeColor = const Color(0xFFFFC800);
      } else if (score >= 50.0) {
        themeColor = const Color(0xFFFF9600);
      } else {
        themeColor = const Color(0xFFFF4B4B);
      }
    } else {
      themeColor = isExam ? const Color(0xFFFF9600) : unitColor;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: themeColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    score != null && score < 50.0
                        ? Icons.refresh_rounded
                        : (isExam
                            ? Icons.emoji_events_rounded
                            : (isCompleted
                                ? Icons.check_circle_rounded
                                : Icons.menu_book_rounded)),
                    color: themeColor,
                    size: 34,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isExam) ...[
                        const Text(
                          '👑 ÜNİTE FİNAL SINAVI',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFFF9600),
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 2),
                      ],
                      Text(
                        lesson.title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF4B4B4B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson.description,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (score != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoBadge(Icons.bolt_rounded, '+${lesson.xpReward} XP', const Color(0xFFFF9600)),
                _buildInfoBadge(Icons.diamond_rounded, '+${lesson.gemReward} 💎', const Color(0xFF1CB0F6)),
                _buildInfoBadge(
                  isExam ? Icons.military_tech_rounded : Icons.quiz_rounded,
                  isExam ? 'Kupa Sınavı' : '${lesson.questions.length} Adım',
                  isExam ? const Color(0xFFFF9600) : const Color(0xFF58CC02),
                ),
              ],
            ),
            const SizedBox(height: 22),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => QuizScreen(lesson: lesson),
                  ),
                );
              },
              child: Text(
                score != null
                    ? (score < 50.0 ? 'TEKRAR DENE (%50 İÇİN)' : (score >= 100.0 ? 'TEKRAR ÇÖZ' : 'PUANI YÜKSELT'))
                    : 'BAŞLA',
                style: const TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }
}

/// Duolingo Tarzı 3D Taktil (İçe Çöken) Ders Butonu
/// Fare üzerine geldiğinde ve tıklandığında fiziksel olarak içe doğru çöker.
class TactileLessonNode extends StatefulWidget {
  final Lesson lesson;
  final Color nodeColor;
  final Color shadowColor;
  final IconData icon;
  final bool isUnlocked;
  final bool isExam;
  final String? badgeText;
  final Color badgeColor;
  final VoidCallback onTap;

  const TactileLessonNode({
    super.key,
    required this.lesson,
    required this.nodeColor,
    required this.shadowColor,
    required this.icon,
    required this.isUnlocked,
    required this.isExam,
    this.badgeText,
    required this.badgeColor,
    required this.onTap,
  });

  @override
  State<TactileLessonNode> createState() => _TactileLessonNodeState();
}

class _TactileLessonNodeState extends State<TactileLessonNode> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final double nodeSize = widget.isExam ? 84.0 : 76.0;
    const double depth = 8.0;
    final hasBadge = widget.badgeText != null;
    const double badgeHeight = 22.0;
    const double badgeSpacing = 6.0;
    final double topMargin = hasBadge ? (badgeHeight + badgeSpacing) : 4.0;

    // 3D Buton içe çökme mekaniği:
    // Basılı değilken: offset = 0 (üst yüzey 8px yüksekte durur, alttaki gölge taban görünür)
    // Üzerine gelince (hover): offset = 3.5 (içe doğru çöker, 4.5px gölge kalır)
    // Tıklandığında (press): offset = depth = 8.0 (tamamen tabana oturup çöker)
    final double offset = _isPressed ? depth : (_isHovered ? 3.5 : 0.0);

    return MouseRegion(
      cursor: widget.isUnlocked ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) {
        setState(() => _isHovered = true);
      },
      onExit: (_) {
        setState(() => _isHovered = false);
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
        },
        child: SizedBox(
          width: nodeSize,
          height: topMargin + nodeSize + depth,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // 3D Taban Silindiri (Shadow Base)
              Positioned(
                top: topMargin + depth,
                left: 0,
                right: 0,
                child: Container(
                  width: nodeSize,
                  height: nodeSize,
                  decoration: BoxDecoration(
                    color: widget.shadowColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Hareketli Üst Yüzey (Animated Face)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 90),
                curve: Curves.easeOutCubic,
                top: topMargin + offset,
                left: 0,
                right: 0,
                child: Container(
                  width: nodeSize,
                  height: nodeSize,
                  decoration: BoxDecoration(
                    color: widget.nodeColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (widget.isUnlocked && widget.nodeColor != const Color(0xFFE5E5E5))
                        BoxShadow(
                          color: widget.nodeColor.withOpacity(0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // İç parlama efekti (Duolingo 3D hilal yansıması)
                      Positioned(
                        top: 5,
                        left: 14,
                        right: 14,
                        child: Container(
                          height: nodeSize * 0.32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.24),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(nodeSize / 2),
                              bottom: const Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      // Ana Simge
                      Icon(
                        widget.icon,
                        color: (widget.isUnlocked || widget.nodeColor != const Color(0xFFE5E5E5))
                            ? Colors.white
                            : const Color(0xFFAFAFAF),
                        size: widget.isExam ? 42 : 36,
                      ),
                    ],
                  ),
                ),
              ),

              // Rozet (Butonun üstünde, hover/press ile birlikte butona bağlı hareket eder)
              if (hasBadge)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 90),
                  curve: Curves.easeOutCubic,
                  top: offset,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: widget.badgeColor,
                        width: 2.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      widget.badgeText!,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w900,
                        color: widget.badgeColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
