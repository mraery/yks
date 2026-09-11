import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import 'premium_purchase_sheet.dart';

class PeanutAdBreakDialog extends StatelessWidget {
  final bool isTenQuestionsBreak;

  const PeanutAdBreakDialog({super.key, this.isTenQuestionsBreak = false});

  static Future<bool> showIfEligible(
    BuildContext context,
    WidgetRef ref, {
    bool isTenQuestionsBreak = false,
  }) async {
    final profile = ref.read(userProfileProvider);
    if (profile.isPremium) return false;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PeanutAdBreakDialog(isTenQuestionsBreak: isTenQuestionsBreak),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      elevation: 12,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Consumer(
        builder: (context, ref, _) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.88,
              maxWidth: 420,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mascot Header with 3D Energy Artwork
                  Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0284C7).withOpacity(0.25),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/energy_break.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => const Center(
                          child: Icon(Icons.bolt_rounded, size: 52, color: Color(0xFFF59E0B)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('⚡ ', style: TextStyle(fontSize: 13)),
                        Text(
                          isTenQuestionsBreak ? '10 SORU MOLASI • ENERJİ ZAMANI' : 'KISA BİR MOLA',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1D4ED8),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    isTenQuestionsBreak ? '10 Soru Bitti, Harika Gidiyorsun! ⚡' : 'Kısa Bir Mola Vakti! ⚡',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Speech Bubble Message
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Text(
                      'Üzgünüm ama reklam koymam lazım... 💛\n\nReklamları sevmediğini biliyorum ama YKSify\'ı ücretsiz ve kaliteli tutabilmek için reklamlara ihtiyacımız var.\n\nİstersen Premium\'a geçerek reklamlardan tamamen kurtulabilir ve sınırsız canla ders çalışabilirsin!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Premium Button (Opens PremiumPurchaseSheet)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C3AED),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 4,
                        shadowColor: const Color(0xFF7C3AED).withOpacity(0.4),
                      ),
                      icon: const Icon(Icons.workspace_premium_rounded, color: Color(0xFFFDE68A), size: 22),
                      label: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '👑 PREMİUM AL (SIFIR REKLAM)',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final purchased = await PremiumPurchaseSheet.show(context, ref);
                        if (purchased == true && context.mounted) {
                          Navigator.of(context).pop(true);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Watch Ad / Continue Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFD97706),
                        side: const BorderSide(color: Color(0xFFF59E0B), width: 1.8),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        backgroundColor: const Color(0xFFFEF3C7).withOpacity(0.3),
                      ),
                      icon: const Text('🥜', style: TextStyle(fontSize: 18)),
                      label: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Reklamı İzle & Devam Et (+5 💎 Hediye)',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      onPressed: () {
                        ref.read(userProfileProvider.notifier).addGems(5);
                        SoundService.playCorrect();
                        Navigator.of(context).pop(false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Text('🥜 ', style: TextStyle(fontSize: 18)),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    'Papağan Fıstık desteğin için teşekkür ediyor! +5 💎 hesabına eklendi.',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: const Color(0xFFD97706),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        );
                      },
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
}
