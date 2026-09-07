import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/lesson_models.dart';
import '../widgets/duo_button.dart';

class LessonCompleteScreen extends StatelessWidget {
  final Lesson lesson;
  final int correctCount;
  final int totalQuestions;
  final bool? isPassedOverride;

  const LessonCompleteScreen({
    super.key,
    required this.lesson,
    required this.correctCount,
    required this.totalQuestions,
    this.isPassedOverride,
  });

  @override
  Widget build(BuildContext context) {
    final accuracy = totalQuestions > 0 ? ((correctCount / totalQuestions) * 100).round() : 0;
    final isPassed = isPassedOverride ?? (accuracy >= 50);

    final titleText = isPassed ? 'Ders Tamamlandı!' : 'Dersi Geçemedin!';
    final titleColor = isPassed ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B);
    final subtitleText = isPassed
        ? 'Harika iş çıkardın! Bilgilerini pekiştirdin ve sonraki dersi açtın.'
        : 'Geçmek için en az %50 başarı sağlamalısın. (Başarın: %$accuracy)\nTekrar deneyerek bilginizi tazeleyin!';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Zafer / Tekrar İkonu & Efekti
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: isPassed ? const Color(0xFFD7FFB8) : const Color(0xFFFFDFE0),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isPassed ? Icons.emoji_events_rounded : Icons.replay_rounded,
                    color: isPassed ? const Color(0xFFFFC800) : const Color(0xFFFF4B4B),
                    size: 84,
                  ),
                ),
              )
                  .animate()
                  .scale(duration: 500.ms, curve: Curves.elasticOut)
                  .then()
                  .shake(duration: 400.ms),

              const SizedBox(height: 24),

              Text(
                titleText,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: titleColor,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: 8),

              Text(
                subtitleText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF777777),
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ).animate().fadeIn(delay: 300.ms),

              const SizedBox(height: 36),

              // Ödül / Durum Kartları
              Row(
                children: [
                  // XP Kartı
                  Expanded(
                    child: _RewardCard(
                      title: 'KAZANILAN XP',
                      value: isPassed ? '+${lesson.xpReward}' : '+0 XP',
                      color: isPassed ? const Color(0xFFFF9600) : const Color(0xFFAFAFAF),
                      icon: Icons.bolt_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // İsabet Kartı
                  Expanded(
                    child: _RewardCard(
                      title: 'İSABET',
                      value: '%$accuracy',
                      color: isPassed ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B),
                      icon: Icons.track_changes_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Elmas / Durum Kartı
                  Expanded(
                    child: _RewardCard(
                      title: isPassed ? 'ELMAS' : 'DURUM',
                      value: isPassed ? '+${lesson.gemReward} 💎' : 'YETERSİZ',
                      color: isPassed ? const Color(0xFF1CB0F6) : const Color(0xFFFF4B4B),
                      icon: isPassed ? Icons.diamond_rounded : Icons.cancel_rounded,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),

              const Spacer(),

              // Alt Buton
              DuoButton(
                text: isPassed ? 'DEVAM ET' : 'TEKRAR DENE 🔄',
                color: isPassed ? DuoButtonColor.green : DuoButtonColor.red,
                height: 54,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _RewardCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.4), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: color.withOpacity(0.8),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
