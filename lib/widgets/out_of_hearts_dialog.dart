import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';
import 'parrot_mascot_widget.dart';
import 'premium_purchase_sheet.dart';

class OutOfHeartsDialog extends StatelessWidget {
  const OutOfHeartsDialog({super.key});

  static bool _isShowing = false;

  static Future<bool> show(BuildContext context, WidgetRef ref) async {
    if (_isShowing) return false;
    _isShowing = true;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const OutOfHeartsDialog(),
    );

    _isShowing = false;
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final profile = ref.watch(userProfileProvider);

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          title: const Row(
            children: [
              Icon(Icons.heart_broken_rounded, color: Color(0xFFE11D48), size: 30),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Canın Tükendi! 💔',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ParrotMascotWidget(size: 68, mood: ParrotMood.oops),
                const SizedBox(height: 12),
                const Text(
                  'Hiç canın kalmadı! Konuya başlayabilmek ve soru çözebilmek için canlarını doldurmalı ya da Premium almalısın:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Color(0xFF475569), height: 1.35),
                ),
                const SizedBox(height: 16),

                // 👑 SEÇENEK 1: PREMİUM AL (SINIRSIZ CAN)
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () async {
                    final purchased = await PremiumPurchaseSheet.show(context, ref);
                    if (purchased == true && context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C3AED).withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: const Color(0xFFFBBF24), width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFBBF24),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.workspace_premium_rounded, color: Color(0xFF4C1D95), size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '👑 PREMİUM AL',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 13.5,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      '♾️ SINIRSIZ CAN',
                                      style: TextStyle(
                                        color: Color(0xFFFDE68A),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 10.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Aylık 58 ₺ veya Yıllık 480 ₺ planlar',
                                style: TextStyle(
                                  color: Color(0xFFE0E7FF),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, color: Colors.white70, size: 22),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // 💎 SEÇENEK 2: 50 ELMAS İLE YENİLE
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    final success = ref.read(userProfileProvider.notifier).refillHearts(withGems: true);
                    if (success) {
                      Navigator.of(context).pop(true);
                      SoundService.playCorrect();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Row(
                            children: [
                              Icon(Icons.favorite_rounded, color: Color(0xFFE11D48)),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '❤️ 50 Elmas karşılığında tüm canların dolduruldu! (5/5 Can)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: const Color(0xFF0284C7),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Yetersiz elmas! 5 canı yenilemek için 50 Elmas gerekli. (Mevcut: ${profile.gems} 💎). Premium alabilirsin!',
                          ),
                          backgroundColor: const Color(0xFFDC2626),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0284C7),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0284C7).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.diamond_rounded, color: Color(0xFFBAE6FD), size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '💎 50 ELMAS İLE YENİLE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13.5,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '5 canın tamamı doldurulur • Bakiye: ${profile.gems} 💎',
                                  style: const TextStyle(
                                    color: Color(0xFFE0F2FE),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded, color: Colors.white70, size: 22),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'Kapat',
                  style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
