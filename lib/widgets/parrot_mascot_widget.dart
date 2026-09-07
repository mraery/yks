import 'dart:math' as math;
import 'package:flutter/material.dart';

enum ParrotMood {
  idle,
  happy,
  thinking,
  oops,
}

/// YKSLingo'nun sevimli, renkli ve bilge Papağan maskotu: Zeki Paşa 🦜
class ParrotMascotWidget extends StatelessWidget {
  final double size;
  final ParrotMood mood;
  final String? speechText;
  final bool animate;

  const ParrotMascotWidget({
    super.key,
    this.size = 110,
    this.mood = ParrotMood.idle,
    this.speechText,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget mascot = CustomPaint(
      size: Size(size, size),
      painter: _ParrotPainter(mood: mood),
    );

    if (speechText != null && speechText!.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSpeechBubble(speechText!),
          const SizedBox(height: 6),
          mascot,
        ],
      );
    }

    return mascot;
  }

  Widget _buildSpeechBubble(String text) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 240),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1E293B),
        ),
      ),
    );
  }
}

class _ParrotPainter extends CustomPainter {
  final ParrotMood mood;

  _ParrotPainter({required this.mood});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w * 0.5;
    final cy = h * 0.52;

    // Renk Paleti (Tropik ve Canlı Macaw Papağanı)
    final redPaint = Paint()..color = const Color(0xFFEF4444); // Canlı Kırmızı (Gövde/Tepe)
    final yellowPaint = Paint()..color = const Color(0xFFFBBF24); // Güneş Sarısı (Göğüs)
    final bluePaint = Paint()..color = const Color(0xFF2563EB); // Kraliyet Mavisi (Kanat)
    final cyanPaint = Paint()..color = const Color(0xFF06B6D4); // Turkuaz (Kanat ucu)
    final greenPaint = Paint()..color = const Color(0xFF10B981); // Zümrüt Yeşili (Kanat ucu)
    final beakPaint = Paint()..color = const Color(0xFFF59E0B); // Gaga Turuncu
    final darkBeakPaint = Paint()..color = const Color(0xFFD97706);
    final eyeWhite = Paint()..color = Colors.white;
    final cheekPaint = Paint()..color = const Color(0xFFFF8A80).withOpacity(0.45);
    final shadowPaint = Paint()..color = Colors.black.withOpacity(0.12);

    // 1. Zemin Gölgesi
    final shadowRect = Rect.fromCenter(
      center: Offset(cx, h * 0.94),
      width: w * 0.58,
      height: h * 0.12,
    );
    canvas.drawOval(shadowRect, shadowPaint);

    // 2. Kuyruk (Mavi & Kırmızı Tüyler)
    final tailPath = Path();
    tailPath.moveTo(cx - w * 0.18, cy + h * 0.2);
    tailPath.quadraticBezierTo(cx - w * 0.38, cy + h * 0.45, cx - w * 0.28, h * 0.92);
    tailPath.quadraticBezierTo(cx - w * 0.15, cy + h * 0.5, cx - w * 0.05, cy + h * 0.3);
    tailPath.close();
    canvas.drawPath(tailPath, bluePaint);

    final tailPath2 = Path();
    tailPath2.moveTo(cx - w * 0.22, cy + h * 0.22);
    tailPath2.quadraticBezierTo(cx - w * 0.45, cy + h * 0.48, cx - w * 0.35, h * 0.88);
    tailPath2.quadraticBezierTo(cx - w * 0.2, cy + h * 0.5, cx - w * 0.1, cy + h * 0.32);
    tailPath2.close();
    canvas.drawPath(tailPath2, cyanPaint);

    // 3. Ayaklar (Turuncu Pençeler)
    final footPaint = Paint()..color = const Color(0xFFF59E0B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx - w * 0.1, h * 0.88), width: w * 0.12, height: h * 0.07),
        const Radius.circular(6),
      ),
      footPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx + w * 0.12, h * 0.88), width: w * 0.12, height: h * 0.07),
        const Radius.circular(6),
      ),
      footPaint,
    );

    // 4. Gövde (Canlı Kırmızı Şekil)
    final bodyPath = Path();
    bodyPath.moveTo(cx - w * 0.24, cy - h * 0.08);
    bodyPath.cubicTo(
      cx - w * 0.32, cy + h * 0.25,
      cx - w * 0.22, cy + h * 0.38,
      cx, cy + h * 0.38,
    );
    bodyPath.cubicTo(
      cx + w * 0.24, cy + h * 0.38,
      cx + w * 0.32, cy + h * 0.22,
      cx + w * 0.24, cy - h * 0.08,
    );
    bodyPath.close();
    canvas.drawPath(bodyPath, redPaint);

    // 5. Göğüs (Güneş Sarısı Canlı Ön Bölge)
    final chestPath = Path();
    chestPath.moveTo(cx - w * 0.12, cy - h * 0.05);
    chestPath.quadraticBezierTo(cx - w * 0.18, cy + h * 0.18, cx - w * 0.04, cy + h * 0.34);
    chestPath.quadraticBezierTo(cx + w * 0.16, cy + h * 0.34, cx + w * 0.18, cy + h * 0.18);
    chestPath.quadraticBezierTo(cx + w * 0.14, cy - h * 0.05, cx - w * 0.12, cy - h * 0.05);
    chestPath.close();
    canvas.drawPath(chestPath, yellowPaint);

    // 6. Baş (Kırmızı Yuvarlak)
    final headCenter = Offset(cx, cy - h * 0.16);
    canvas.drawCircle(headCenter, w * 0.27, redPaint);

    // 7. Tepe İbiği / Tepelik (Renkli Papağan Tüy Taçları)
    final crestPath = Path();
    crestPath.moveTo(cx - w * 0.1, cy - h * 0.38);
    crestPath.quadraticBezierTo(cx - w * 0.06, cy - h * 0.52, cx + w * 0.04, cy - h * 0.5);
    crestPath.quadraticBezierTo(cx + w * 0.02, cy - h * 0.4, cx + w * 0.06, cy - h * 0.38);
    crestPath.close();
    canvas.drawPath(crestPath, yellowPaint);

    final crestPath2 = Path();
    crestPath2.moveTo(cx + w * 0.02, cy - h * 0.38);
    crestPath2.quadraticBezierTo(cx + w * 0.12, cy - h * 0.53, cx + w * 0.2, cy - h * 0.46);
    crestPath2.quadraticBezierTo(cx + w * 0.14, cy - h * 0.38, cx + w * 0.12, cy - h * 0.34);
    crestPath2.close();
    canvas.drawPath(crestPath2, cyanPaint);

    // 8. Sol / Sağ Kanatlar (Katmanlı Renkler: Mavi -> Yeşil -> Sarı)
    if (mood == ParrotMood.happy) {
      // Kanatlar havada kutlama yapıyor!
      _drawWingUp(canvas, w, h, cx - w * 0.22, cy, isLeft: true, blue: bluePaint, green: greenPaint, yellow: yellowPaint);
      _drawWingUp(canvas, w, h, cx + w * 0.22, cy, isLeft: false, blue: bluePaint, green: greenPaint, yellow: yellowPaint);
    } else {
      // Normal veya düşünme kanadı
      _drawWingFolded(canvas, w, h, cx - w * 0.22, cy, isLeft: true, blue: bluePaint, green: greenPaint, yellow: yellowPaint);
      _drawWingFolded(canvas, w, h, cx + w * 0.24, cy, isLeft: false, blue: bluePaint, green: greenPaint, yellow: yellowPaint);
    }

    // 9. Yanak Beyazlığı (Papağanlara has beyaz deri halkası)
    final eyePatchLeft = Rect.fromCenter(center: Offset(cx - w * 0.11, cy - h * 0.18), width: w * 0.16, height: h * 0.18);
    final eyePatchRight = Rect.fromCenter(center: Offset(cx + w * 0.11, cy - h * 0.18), width: w * 0.16, height: h * 0.18);
    canvas.drawOval(eyePatchLeft, eyeWhite);
    canvas.drawOval(eyePatchRight, eyeWhite);

    // 10. Gözler (Büyük, Sevimli ve Zeki)
    _drawEyes(canvas, w, h, cx, cy);

    // 11. Yanak Allıkları
    canvas.drawCircle(Offset(cx - w * 0.2, cy - h * 0.1), w * 0.055, cheekPaint);
    canvas.drawCircle(Offset(cx + w * 0.2, cy - h * 0.1), w * 0.055, cheekPaint);

    // 12. Kıvrık Papağan Gagası
    final beakPath = Path();
    beakPath.moveTo(cx - w * 0.09, cy - h * 0.14);
    beakPath.quadraticBezierTo(cx, cy - h * 0.18, cx + w * 0.09, cy - h * 0.14);
    beakPath.quadraticBezierTo(cx + w * 0.14, cy - h * 0.04, cx, cy + h * 0.02);
    beakPath.quadraticBezierTo(cx - w * 0.14, cy - h * 0.04, cx - w * 0.09, cy - h * 0.14);
    beakPath.close();
    canvas.drawPath(beakPath, beakPaint);

    // Alt Gaga parçası
    final lowerBeakPath = Path();
    lowerBeakPath.moveTo(cx - w * 0.06, cy - h * 0.08);
    lowerBeakPath.quadraticBezierTo(cx, cy - h * 0.02, cx + w * 0.06, cy - h * 0.08);
    lowerBeakPath.close();
    canvas.drawPath(lowerBeakPath, darkBeakPaint);

    // 13. Ruh Haline Göre Özel Ekstralar (Gözlük veya Terleme damlası)
    if (mood == ParrotMood.thinking) {
      // Sevimli Ders Gözlüğü
      final glassesPaint = Paint()
        ..color = const Color(0xFF0F172A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.025;
      canvas.drawCircle(Offset(cx - w * 0.11, cy - h * 0.18), w * 0.09, glassesPaint);
      canvas.drawCircle(Offset(cx + w * 0.11, cy - h * 0.18), w * 0.09, glassesPaint);
      canvas.drawLine(
        Offset(cx - w * 0.02, cy - h * 0.18),
        Offset(cx + w * 0.02, cy - h * 0.18),
        glassesPaint,
      );
    } else if (mood == ParrotMood.oops) {
      // Terleme Damlası (Tüh/Oops)
      final dropPaint = Paint()..color = const Color(0xFF38BDF8);
      final dropPath = Path();
      dropPath.moveTo(cx + w * 0.28, cy - h * 0.32);
      dropPath.quadraticBezierTo(cx + w * 0.33, cy - h * 0.24, cx + w * 0.28, cy - h * 0.22);
      dropPath.quadraticBezierTo(cx + w * 0.23, cy - h * 0.24, cx + w * 0.28, cy - h * 0.32);
      canvas.drawPath(dropPath, dropPaint);
    }
  }

  void _drawEyes(Canvas canvas, double w, double h, double cx, double cy) {
    if (mood == ParrotMood.happy) {
      // Mutlu Gülen Kavisli Gözler (^ ^)
      final happyEyePaint = Paint()
        ..color = const Color(0xFF0F172A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.032
        ..strokeCap = StrokeCap.round;

      final leftEyePath = Path();
      leftEyePath.moveTo(cx - w * 0.16, cy - h * 0.17);
      leftEyePath.quadraticBezierTo(cx - w * 0.11, cy - h * 0.22, cx - w * 0.06, cy - h * 0.17);
      canvas.drawPath(leftEyePath, happyEyePaint);

      final rightEyePath = Path();
      rightEyePath.moveTo(cx + w * 0.06, cy - h * 0.17);
      rightEyePath.quadraticBezierTo(cx + w * 0.11, cy - h * 0.22, cx + w * 0.16, cy - h * 0.17);
      canvas.drawPath(rightEyePath, happyEyePaint);
    } else {
      // Normal / Düşünceli / Meraklı Yuvarlak Canlı Gözler
      final eyeBlack = Paint()..color = const Color(0xFF0F172A);
      final eyeSparkle = Paint()..color = Colors.white;
      final leftEyeCenter = Offset(cx - w * 0.11, cy - h * 0.18);
      final rightEyeCenter = Offset(cx + w * 0.11, cy - h * 0.18);

      canvas.drawCircle(leftEyeCenter, w * 0.055, eyeBlack);
      canvas.drawCircle(rightEyeCenter, w * 0.055, eyeBlack);

      // Göz Işıltıları (Tatlılık katmak için)
      canvas.drawCircle(Offset(cx - w * 0.125, cy - h * 0.195), w * 0.02, eyeSparkle);
      canvas.drawCircle(Offset(cx - w * 0.095, cy - h * 0.165), w * 0.01, eyeSparkle);

      canvas.drawCircle(Offset(cx + w * 0.095, cy - h * 0.195), w * 0.02, eyeSparkle);
      canvas.drawCircle(Offset(cx + w * 0.125, cy - h * 0.165), w * 0.01, eyeSparkle);
    }
  }

  void _drawWingFolded(Canvas canvas, double w, double h, double startX, double cy,
      {required bool isLeft, required Paint blue, required Paint green, required Paint yellow}) {
    final dir = isLeft ? -1.0 : 1.0;
    final path = Path();
    path.moveTo(startX, cy - h * 0.08);
    path.quadraticBezierTo(startX + dir * w * 0.18, cy + h * 0.1, startX + dir * w * 0.05, cy + h * 0.28);
    path.quadraticBezierTo(startX - dir * w * 0.05, cy + h * 0.15, startX, cy - h * 0.08);
    path.close();
    canvas.drawPath(path, blue);

    final pathInner = Path();
    pathInner.moveTo(startX, cy);
    pathInner.quadraticBezierTo(startX + dir * w * 0.14, cy + h * 0.12, startX + dir * w * 0.04, cy + h * 0.24);
    pathInner.quadraticBezierTo(startX - dir * w * 0.02, cy + h * 0.15, startX, cy);
    pathInner.close();
    canvas.drawPath(pathInner, green);
  }

  void _drawWingUp(Canvas canvas, double w, double h, double startX, double cy,
      {required bool isLeft, required Paint blue, required Paint green, required Paint yellow}) {
    final dir = isLeft ? -1.0 : 1.0;
    final path = Path();
    path.moveTo(startX, cy - h * 0.05);
    path.quadraticBezierTo(startX + dir * w * 0.25, cy - h * 0.25, startX + dir * w * 0.22, cy - h * 0.1);
    path.quadraticBezierTo(startX + dir * w * 0.1, cy + h * 0.1, startX, cy - h * 0.05);
    path.close();
    canvas.drawPath(path, blue);

    final pathGreen = Path();
    pathGreen.moveTo(startX, cy - h * 0.02);
    pathGreen.quadraticBezierTo(startX + dir * w * 0.18, cy - h * 0.16, startX + dir * w * 0.16, cy - h * 0.06);
    pathGreen.quadraticBezierTo(startX + dir * w * 0.06, cy + h * 0.08, startX, cy - h * 0.02);
    pathGreen.close();
    canvas.drawPath(pathGreen, green);
  }

  @override
  bool shouldRepaint(covariant _ParrotPainter oldDelegate) => oldDelegate.mood != mood;
}
