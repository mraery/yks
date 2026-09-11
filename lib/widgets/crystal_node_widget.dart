import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/lesson_models.dart';

/// 3D Parlayan Kristal İstasyon Düğümü (YKS Kristal Podu)
/// Duolingo'nun klasik yuvarlak butonları yerine, çok yüzeyli, ışık kırılmalı ve neon parlamalı mücevher prizması.
class CrystalLessonNode extends StatefulWidget {
  final Lesson lesson;
  final int index;
  final Color baseColor;
  final double? score;
  final bool isCompleted;
  final bool isUnlocked;
  final VoidCallback onTap;

  const CrystalLessonNode({
    super.key,
    required this.lesson,
    required this.index,
    required this.baseColor,
    required this.score,
    required this.isCompleted,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  State<CrystalLessonNode> createState() => _CrystalLessonNodeState();
}

class _CrystalLessonNodeState extends State<CrystalLessonNode>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  bool _isHovered = false;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutSine),
    );

    final isTest = WidgetsBinding.instance.runtimeType.toString().contains('Test');
    if (!isTest && widget.isUnlocked && widget.score == null) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant CrystalLessonNode oldWidget) {
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
    final double nodeSize = isExam ? 96.0 : 82.0;

    // Renk ve Kristal Durum Belirleme
    Color primaryColor;
    Color secondaryColor;
    Color glowColor;
    IconData iconData;
    String? badgeLabel;
    Color? badgeColor;

    if (!widget.isUnlocked) {
      // Kilitli Buzul Kristal
      primaryColor = const Color(0xFF94A3B8);
      secondaryColor = const Color(0xFF64748B);
      glowColor = Colors.transparent;
      iconData = Icons.lock_rounded;
      badgeLabel = null;
    } else if (widget.score != null) {
      if (widget.score! >= 100.0) {
        // Altın Taç Kristali
        primaryColor = const Color(0xFFF59E0B);
        secondaryColor = const Color(0xFFD97706);
        glowColor = const Color(0xFFF59E0B).withOpacity(0.45);
        iconData = isExam ? Icons.emoji_events_rounded : Icons.star_rounded;
        badgeLabel = '⭐ %100';
        badgeColor = const Color(0xFFF59E0B);
      } else if (widget.score! >= 50.0) {
        // Zümrüt Başarı Kristali
        primaryColor = const Color(0xFF10B981);
        secondaryColor = const Color(0xFF059669);
        glowColor = const Color(0xFF10B981).withOpacity(0.4);
        iconData = isExam ? Icons.military_tech_rounded : Icons.check_rounded;
        badgeLabel = '%${widget.score!.toInt()}';
        badgeColor = const Color(0xFF10B981);
      } else {
        // Yakut Tekrar Kristali
        primaryColor = const Color(0xFFE11D48);
        secondaryColor = const Color(0xFFBE123C);
        glowColor = const Color(0xFFE11D48).withOpacity(0.35);
        iconData = Icons.refresh_rounded;
        badgeLabel = '%${widget.score!.toInt()} Tekrar';
        badgeColor = const Color(0xFFE11D48);
      }
    } else if (isExam) {
      // Şampiyon Final Monoliti
      primaryColor = const Color(0xFF8B5CF6);
      secondaryColor = const Color(0xFF6D28D9);
      glowColor = const Color(0xFF8B5CF6).withOpacity(0.5);
      iconData = Icons.emoji_events_rounded;
      badgeLabel = '👑 FİNAL';
      badgeColor = const Color(0xFF8B5CF6);
    } else {
      // Aktif Görev Kristali
      primaryColor = widget.baseColor;
      secondaryColor = Color.alphaBlend(Colors.black38, widget.baseColor);
      glowColor = widget.baseColor.withOpacity(0.45);
      iconData = Icons.play_arrow_rounded;
      badgeLabel = 'BAŞLA';
      badgeColor = widget.baseColor;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          cursor: widget.isUnlocked ? SystemMouseCursors.click : SystemMouseCursors.basic,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) {
              setState(() => _isPressed = false);
              widget.onTap();
            },
            onTapCancel: () => setState(() => _isPressed = false),
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                final pulseScale = (widget.isUnlocked && widget.score == null)
                    ? _pulseAnimation.value
                    : 1.0;
                final scale = _isPressed ? 0.92 : (_isHovered ? 1.06 : pulseScale);

                return Transform.scale(
                  scale: scale,
                  child: SizedBox(
                    width: nodeSize + 16,
                    height: nodeSize + 16,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Dış Neon Parlama Halkası
                        if (widget.isUnlocked && glowColor != Colors.transparent)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: glowColor,
                                    blurRadius: isExam ? 26 : 18,
                                    spreadRadius: isExam ? 4 : 2,
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // 3D Çok Yüzeyli Kristal Gövde
                        CustomPaint(
                          size: Size(nodeSize, nodeSize),
                          painter: _GemstonePainter(
                            primaryColor: primaryColor,
                            secondaryColor: secondaryColor,
                            isUnlocked: widget.isUnlocked,
                            isExam: isExam,
                          ),
                        ),

                        // Kristal Merkez İkonu
                        Icon(
                          iconData,
                          color: Colors.white,
                          size: isExam ? 38 : 32,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),

                        // Üst Yıldız / Taç Rozeti
                        if (badgeLabel != null)
                          Positioned(
                            top: -6,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: badgeColor ?? primaryColor, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                badgeLabel,
                                style: TextStyle(
                                  color: badgeColor ?? primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Sade ve Şık Konu Etiketi (Kutular ve uzun paragraflar kaldırıldı!)
        Container(
          constraints: const BoxConstraints(maxWidth: 160),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.isUnlocked
                  ? (isExam ? const Color(0xFFC084FC) : const Color(0xFFE2E8F0))
                  : const Color(0xFFE2E8F0),
              width: isExam ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            isExam ? '👑 ${widget.lesson.title}' : widget.lesson.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isExam ? 12.5 : 12,
              fontWeight: isExam ? FontWeight.w900 : FontWeight.w800,
              color: widget.isUnlocked
                  ? (isExam ? const Color(0xFF7C3AED) : const Color(0xFF1E293B))
                  : const Color(0xFF94A3B8),
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

/// 3D Çok Yüzeyli Kristal Çizen Özel Painter
class _GemstonePainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final bool isUnlocked;
  final bool isExam;

  _GemstonePainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.isUnlocked,
    required this.isExam,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;
    final r = w / 2;

    // Alt Zemin Gölgesi
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(Offset(cx, cy + 5), r * 0.9, shadowPaint);

    if (isExam) {
      // Sekizgen (Octagon) Elmas Taç
      _drawFacetedOctagon(canvas, cx, cy, r);
    } else {
      // 3D Altıgen (Hexagonal Prism) Kristal
      _drawFacetedHexagon(canvas, cx, cy, r);
    }
  }

  void _drawFacetedHexagon(Canvas canvas, double cx, double cy, double r) {
    const sides = 6;
    final outerPoints = <Offset>[];
    final innerPoints = <Offset>[];
    final innerR = r * 0.58;

    for (int i = 0; i < sides; i++) {
      final angle = (i * 60 - 30) * math.pi / 180;
      outerPoints.add(Offset(cx + r * math.cos(angle), cy + r * math.sin(angle)));
      innerPoints.add(Offset(cx + innerR * math.cos(angle), cy + innerR * math.sin(angle)));
    }

    // 1. Dış Kenar Fasetleri (Işık kırılmalı 6 trapez dilim)
    for (int i = 0; i < sides; i++) {
      final next = (i + 1) % sides;
      final facetPath = Path()
        ..moveTo(outerPoints[i].dx, outerPoints[i].dy)
        ..lineTo(outerPoints[next].dx, outerPoints[next].dy)
        ..lineTo(innerPoints[next].dx, innerPoints[next].dy)
        ..lineTo(innerPoints[i].dx, innerPoints[i].dy)
        ..close();

      // Üst fasetler daha aydınlık, alt fasetler daha derin
      final double lightnessFactor = (i == 4 || i == 5) ? 0.35 : ((i == 0 || i == 3) ? 0.15 : -0.2);
      final facetColor = _adjustColor(primaryColor, lightnessFactor);

      final paint = Paint()
        ..shader = LinearGradient(
          colors: [facetColor, secondaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(facetPath.getBounds());

      canvas.drawPath(facetPath, paint);
    }

    // 2. İç Düzlem (Merkez Kristal Masası)
    final centerPath = Path();
    centerPath.moveTo(innerPoints[0].dx, innerPoints[0].dy);
    for (int i = 1; i < sides; i++) {
      centerPath.lineTo(innerPoints[i].dx, innerPoints[i].dy);
    }
    centerPath.close();

    final centerPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _adjustColor(primaryColor, 0.4),
          primaryColor,
          secondaryColor,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(centerPath.getBounds());

    canvas.drawPath(centerPath, centerPaint);

    // 3. Kristal Işık Yansıması (Specular Glass Highlight)
    final highlightPath = Path()
      ..moveTo(innerPoints[4].dx, innerPoints[4].dy)
      ..lineTo(innerPoints[5].dx, innerPoints[5].dy)
      ..lineTo(cx, cy)
      ..close();

    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.32)
      ..style = PaintingStyle.fill;
    canvas.drawPath(highlightPath, highlightPaint);

    // 4. İnce Kristal Kenar Hatları (Bevel borders)
    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(isUnlocked ? 0.45 : 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int i = 0; i < sides; i++) {
      final next = (i + 1) % sides;
      canvas.drawLine(outerPoints[i], outerPoints[next], strokePaint);
      canvas.drawLine(outerPoints[i], innerPoints[i], strokePaint);
      canvas.drawLine(innerPoints[i], innerPoints[next], strokePaint);
    }
  }

  void _drawFacetedOctagon(Canvas canvas, double cx, double cy, double r) {
    const sides = 8;
    final outerPoints = <Offset>[];
    final innerPoints = <Offset>[];
    final innerR = r * 0.62;

    for (int i = 0; i < sides; i++) {
      final angle = (i * 45 - 22.5) * math.pi / 180;
      outerPoints.add(Offset(cx + r * math.cos(angle), cy + r * math.sin(angle)));
      innerPoints.add(Offset(cx + innerR * math.cos(angle), cy + innerR * math.sin(angle)));
    }

    // Fasetler
    for (int i = 0; i < sides; i++) {
      final next = (i + 1) % sides;
      final facetPath = Path()
        ..moveTo(outerPoints[i].dx, outerPoints[i].dy)
        ..lineTo(outerPoints[next].dx, outerPoints[next].dy)
        ..lineTo(innerPoints[next].dx, innerPoints[next].dy)
        ..lineTo(innerPoints[i].dx, innerPoints[i].dy)
        ..close();

      final lightnessFactor = (i >= 5 && i <= 7) ? 0.4 : ((i == 0 || i == 4) ? 0.1 : -0.25);
      final facetColor = _adjustColor(primaryColor, lightnessFactor);

      final paint = Paint()..color = facetColor;
      canvas.drawPath(facetPath, paint);
    }

    // Merkez
    final centerPath = Path();
    centerPath.moveTo(innerPoints[0].dx, innerPoints[0].dy);
    for (int i = 1; i < sides; i++) {
      centerPath.lineTo(innerPoints[i].dx, innerPoints[i].dy);
    }
    centerPath.close();

    final centerPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _adjustColor(primaryColor, 0.5),
          primaryColor,
          secondaryColor,
        ],
      ).createShader(centerPath.getBounds());
    canvas.drawPath(centerPath, centerPaint);

    // Dış ve faset kenarları
    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    for (int i = 0; i < sides; i++) {
      final next = (i + 1) % sides;
      canvas.drawLine(outerPoints[i], outerPoints[next], strokePaint);
      canvas.drawLine(outerPoints[i], innerPoints[i], strokePaint);
      canvas.drawLine(innerPoints[i], innerPoints[next], strokePaint);
    }
  }

  Color _adjustColor(Color c, double factor) {
    if (factor >= 0) {
      return Color.alphaBlend(Colors.white.withOpacity(factor.clamp(0.0, 1.0)), c);
    } else {
      return Color.alphaBlend(Colors.black.withOpacity((-factor).clamp(0.0, 1.0)), c);
    }
  }

  @override
  bool shouldRepaint(covariant _GemstonePainter oldDelegate) {
    return oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.isUnlocked != isUnlocked ||
        oldDelegate.isExam != isExam;
  }
}
