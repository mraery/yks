import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lesson_models.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import '../widgets/duo_button.dart';
import '../widgets/parrot_mascot_widget.dart';
import '../widgets/peanut_ad_break_dialog.dart';

class LessonCompleteScreen extends ConsumerStatefulWidget {
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
  ConsumerState<LessonCompleteScreen> createState() => _LessonCompleteScreenState();
}

class _LessonCompleteScreenState extends ConsumerState<LessonCompleteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final accuracy = widget.totalQuestions > 0
          ? ((widget.correctCount / widget.totalQuestions) * 100).round()
          : 0;
      final isPassed = widget.isPassedOverride ?? (accuracy >= 50);
      if (isPassed) {
        SoundService.playLessonPass();
      } else {
        SoundService.playLessonFail();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final accuracy = widget.totalQuestions > 0
        ? ((widget.correctCount / widget.totalQuestions) * 100).round()
        : 0;
    final isPassed = widget.isPassedOverride ?? (accuracy >= 50);

    final titleText = isPassed ? 'Dersi Geçtin! 🎉' : 'Dersi Geçemedin! 💔';
    final titleColor = isPassed ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final subtitleText = isPassed
        ? 'Harika iş çıkardın! Bilgilerini pekiştirdin ve sonraki dersi açtın.'
        : 'Geçmek için en az %50 başarı sağlamalısın. (Başarın: %$accuracy)\nTekrar deneyerek bilgini tazele!';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Renkli Papağan Maskotu Kutlama / Teselli Alanı
              Animate(
                effects: [
                  ScaleEffect(duration: 500.ms, curve: Curves.elasticOut),
                  ShakeEffect(duration: 400.ms, delay: 500.ms),
                ],
                child: ParrotMascotWidget(
                  size: 130,
                  mood: isPassed ? ParrotMood.happy : ParrotMood.oops,
                  speechText: isPassed
                      ? 'Tebrikler! +${widget.lesson.xpReward} XP kazandın! 🎉'
                      : 'Pes etmek yok! Taktikleri hatırla, bir daha deneyelim! 🦜',
                ),
              ),

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
                      value: isPassed ? '+${widget.lesson.xpReward}' : '+0 XP',
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
                      value: isPassed ? '+${widget.lesson.gemReward} 💎' : 'YETERSİZ',
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
                onPressed: () async {
                  if (isPassed) {
                    final profile = ref.read(userProfileProvider);
                    if (!profile.isPremium && profile.completedLessonIds.length % 3 == 0) {
                      await PeanutAdBreakDialog.showIfEligible(context, ref);
                    }
                  }
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
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
