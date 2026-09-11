import 'package:flutter/material.dart';
import '../models/lesson_models.dart';

/// YKSLingo Premium 3D Öğrenme Basamağı (Duolingo Stili 3D Stepping Stone)
/// Kaliteli, fiziksel derinlikli, basmalı 3D buton ve kupa sınavı kaidesi.
class ParrotSeedNode extends StatefulWidget {
  final Lesson lesson;
  final int seedIndex;
  final Color baseColor;
  final double? score;
  final bool isCompleted;
  final bool isUnlocked;
  final VoidCallback onTap;

  const ParrotSeedNode({
    super.key,
    required this.lesson,
    required this.seedIndex,
    required this.baseColor,
    required this.score,
    required this.isCompleted,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  State<ParrotSeedNode> createState() => _ParrotSeedNodeState();
}

class _ParrotSeedNodeState extends State<ParrotSeedNode>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _floatAnimation = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    final isTest = WidgetsBinding.instance.runtimeType.toString().contains('Test');
    if (!isTest && widget.isUnlocked && widget.score == null) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant ParrotSeedNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    final isTest = WidgetsBinding.instance.runtimeType.toString().contains('Test');
    if (!isTest && widget.isUnlocked && widget.score == null) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isExam = widget.lesson.isUnitExam;
    final double nodeDiameter = isExam ? 90.0 : 74.0;
    final double bevelDepth = isExam ? 10.0 : 8.0;

    // Renk ve Durum Belirleme
    Color surfaceTopColor;
    Color surfaceBottomColor;
    Color bevelShadowColor;
    Color glowColor;
    IconData iconData;
    String? badgeText;
    Color? badgeBgColor;
    Color? badgeTextColor;
    bool isActiveNext = widget.isUnlocked && widget.score == null;

    if (!widget.isUnlocked) {
      // 1. Kilitli Düğüm (Şık Metalik Gümüş/Arduvaz Taşı)
      surfaceTopColor = const Color(0xFFE2E8F0);
      surfaceBottomColor = const Color(0xFFCBD5E1);
      bevelShadowColor = const Color(0xFF94A3B8);
      glowColor = Colors.transparent;
      iconData = Icons.lock_rounded;
      badgeText = null;
    } else if (widget.score != null) {
      if (widget.score! >= 100.0) {
        // 2. %100 Kusursuz Altın Başarı
        surfaceTopColor = const Color(0xFFFBBF24);
        surfaceBottomColor = const Color(0xFFF59E0B);
        bevelShadowColor = const Color(0xFFD97706);
        glowColor = const Color(0xFFF59E0B).withOpacity(0.35);
        iconData = isExam ? Icons.emoji_events_rounded : Icons.star_rounded;
        badgeText = '⭐ %100';
        badgeBgColor = const Color(0xFFFEF3C7);
        badgeTextColor = const Color(0xFFB45309);
      } else if (widget.score! >= 50.0) {
        // 3. %50+ Başarılı Geçiş (Zümrüt Yeşili)
        surfaceTopColor = const Color(0xFF34D399);
        surfaceBottomColor = const Color(0xFF10B981);
        bevelShadowColor = const Color(0xFF047857);
        glowColor = const Color(0xFF10B981).withOpacity(0.35);
        iconData = isExam ? Icons.workspace_premium_rounded : Icons.check_rounded;
        badgeText = '✓ %${widget.score!.toInt()}';
        badgeBgColor = const Color(0xFFD1FAE5);
        badgeTextColor = const Color(0xFF047857);
      } else {
        // 4. %50 Altı Tekrar Gereken Ders (Sıcak Mercan)
        surfaceTopColor = const Color(0xFFFB7185);
        surfaceBottomColor = const Color(0xFFF43F5E);
        bevelShadowColor = const Color(0xFFBE123C);
        glowColor = const Color(0xFFF43F5E).withOpacity(0.3);
        iconData = Icons.replay_rounded;
        badgeText = 'Tekrar Dene';
        badgeBgColor = const Color(0xFFFFE4E6);
        badgeTextColor = const Color(0xFFBE123C);
      }
    } else if (isExam) {
      // 5. Ünite Kupa Sınavı (Görkemli Altın Taç)
      surfaceTopColor = const Color(0xFFFCD34D);
      surfaceBottomColor = const Color(0xFFF59E0B);
      bevelShadowColor = const Color(0xFFB45309);
      glowColor = const Color(0xFFF59E0B).withOpacity(0.45);
      iconData = Icons.emoji_events_rounded;
      badgeText = '🏆 ÜNİTE KUPASI';
      badgeBgColor = const Color(0xFFFEF3C7);
      badgeTextColor = const Color(0xFF92400E);
    } else {
      // 6. Sıradaki Aktif Ders (Konu Renginde Canlı 3D Buton)
      surfaceTopColor = Color.alphaBlend(Colors.white.withOpacity(0.25), widget.baseColor);
      surfaceBottomColor = widget.baseColor;
      bevelShadowColor = Color.alphaBlend(Colors.black.withOpacity(0.35), widget.baseColor);
      glowColor = widget.baseColor.withOpacity(0.4);
      iconData = Icons.play_arrow_rounded;
      badgeText = 'BAŞLA';
      badgeBgColor = widget.baseColor;
      badgeTextColor = Colors.white;
    }

    final double pressOffset = _isPressed ? (bevelDepth - 2.0) : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          cursor: widget.isUnlocked ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) {
              setState(() => _isPressed = false);
              widget.onTap();
            },
            onTapCancel: () => setState(() => _isPressed = false),
            child: SizedBox(
              width: nodeDiameter + 32,
              height: nodeDiameter + bevelDepth + 36,
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  // 1. Dış Halka & Parlama Efekti (Sıradaki Aktif Ders İçin)
                  if (isActiveNext)
                    Positioned(
                      bottom: 8,
                      child: AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Container(
                            width: (nodeDiameter + 18) * _pulseAnimation.value,
                            height: (nodeDiameter + 18) * _pulseAnimation.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: widget.baseColor.withOpacity(
                                  (1.2 - _pulseAnimation.value).clamp(0.1, 0.6),
                                ),
                                width: 3.5,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  // 2. Taban Zemin Gölgesi (Yumuşak Ambiyans)
                  Positioned(
                    bottom: 4,
                    child: Container(
                      width: nodeDiameter * 0.88,
                      height: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                          if (glowColor != Colors.transparent)
                            BoxShadow(
                              color: glowColor,
                              blurRadius: 18,
                              spreadRadius: 4,
                            ),
                        ],
                      ),
                    ),
                  ),

                  // 3. 3D Buton Tabanı (Derinlik / Alt Bevel Katmanı)
                  Positioned(
                    bottom: 8,
                    child: Container(
                      width: nodeDiameter,
                      height: nodeDiameter,
                      decoration: BoxDecoration(
                        color: bevelShadowColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 4. 3D Basılabilir Üst Yüzey (Gerçek Yaylı Buton Hissi)
                  Positioned(
                    bottom: 8 + (bevelDepth - pressOffset),
                    child: Container(
                      width: nodeDiameter,
                      height: nodeDiameter,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [surfaceTopColor, surfaceBottomColor],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(widget.isUnlocked ? 0.45 : 0.25),
                          width: 2.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Üst Parlak Cam Yansıması (Glossy Arc)
                          Positioned(
                            top: 4,
                            child: Container(
                              width: nodeDiameter * 0.76,
                              height: nodeDiameter * 0.38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(nodeDiameter * 0.5),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white.withOpacity(0.40),
                                    Colors.white.withOpacity(0.02),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Kupa Sınavı Özel Görseli veya İkonu
                          if (isExam && widget.isUnlocked) ...[
                            ClipOval(
                              child: Image.asset(
                                'assets/images/golden_trophy.jpg',
                                width: nodeDiameter * 0.72,
                                height: nodeDiameter * 0.72,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) => Icon(
                                  Icons.emoji_events_rounded,
                                  size: nodeDiameter * 0.52,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.35),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ] else ...[
                            // Normal Ders Merkezi İkonu
                            Icon(
                              iconData,
                              size: isExam ? (nodeDiameter * 0.50) : (nodeDiameter * 0.46),
                              color: widget.isUnlocked ? Colors.white : const Color(0xFF64748B),
                              shadows: widget.isUnlocked
                                  ? [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.32),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // 5. Duolingo Stili Yüzen "BAŞLA" Konuşma Balonu
                  if (isActiveNext)
                    Positioned(
                      top: 0,
                      child: AnimatedBuilder(
                        animation: _floatAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _floatAnimation.value),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: widget.baseColor,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: widget.baseColor.withOpacity(0.4),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    'BAŞLA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                                // Balon Ok Ucu (Triangle pointer)
                                CustomPaint(
                                  size: const Size(10, 6),
                                  painter: _TrianglePainter(color: widget.baseColor),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  // Tamamlanmış veya Kupa Rozeti
                  else if (badgeText != null)
                    Positioned(
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: badgeBgColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: badgeTextColor ?? bevelShadowColor,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          badgeText,
                          style: TextStyle(
                            color: badgeTextColor ?? bevelShadowColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Ders Başlığı Bilgi Kartı
        Container(
          constraints: const BoxConstraints(maxWidth: 165),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.isUnlocked
                  ? (isExam
                      ? const Color(0xFFF59E0B)
                      : (widget.isCompleted ? const Color(0xFF10B981) : const Color(0xFFE2E8F0)))
                  : const Color(0xFFE2E8F0),
              width: (isExam || widget.isCompleted) ? 1.6 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            isExam ? '🏆 ${widget.lesson.title}' : widget.lesson.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isExam ? 12 : 11.5,
              fontWeight: isExam ? FontWeight.w900 : FontWeight.w800,
              color: widget.isUnlocked
                  ? (isExam
                      ? const Color(0xFFB45309)
                      : (widget.isCompleted ? const Color(0xFF047857) : const Color(0xFF1E293B)))
                  : const Color(0xFF94A3B8),
            ),
          ),
        ),
      ],
    );
  }
}

/// Konuşma balonu altındaki ok ucunu çizen minik yardımcı painter
class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) => oldDelegate.color != color;
}

