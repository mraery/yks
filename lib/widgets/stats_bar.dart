import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import 'out_of_hearts_dialog.dart';
import 'premium_purchase_sheet.dart';
import 'promo_code_dialog.dart';

class StatsBar extends ConsumerWidget implements PreferredSizeWidget {
  const StatsBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: const Border(
          bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1.5),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Streak
            _ModernStatChip(
              icon: Icons.local_fire_department_rounded,
              iconColor: const Color(0xFFEA580C),
              bgColor: const Color(0xFFFFF7ED),
              borderColor: const Color(0xFFFED7AA),
              value: '${profile.streak}',
              label: 'GÜN',
            ),
            // Gems (tıklanabilir - Promosyon Kodu & Mağaza)
            InkWell(
              onTap: () => PromoCodeDialog.show(context),
              borderRadius: BorderRadius.circular(20),
              child: _ModernStatChip(
                icon: Icons.diamond_rounded,
                iconColor: const Color(0xFF0284C7),
                bgColor: const Color(0xFFF0F9FF),
                borderColor: const Color(0xFFBAE6FD),
                value: '${profile.gems}',
                label: 'ELMAS',
              ),
            ),
            // Hearts
            InkWell(
              onTap: () {
                if (profile.hearts <= 0 && !profile.isPremium) {
                  OutOfHeartsDialog.show(context, ref);
                } else {
                  _showHeartDialog(context, ref, profile.hearts, profile.gems, isPremium: profile.isPremium);
                }
              },
              borderRadius: BorderRadius.circular(20),
              child: _ModernStatChip(
                icon: profile.isPremium ? Icons.workspace_premium_rounded : Icons.favorite_rounded,
                iconColor: profile.isPremium ? const Color(0xFFD97706) : const Color(0xFFE11D48),
                bgColor: profile.isPremium ? const Color(0xFFFEF3C7) : const Color(0xFFFFF1F2),
                borderColor: profile.isPremium ? const Color(0xFFFDE68A) : const Color(0xFFFECDD3),
                value: profile.isPremium ? '♾️' : '${profile.hearts}',
                label: profile.isPremium ? 'PREMİUM' : 'CAN',
              ),
            ),
            // Promosyon Kodu Butonu
            InkWell(
              onTap: () => PromoCodeDialog.show(context),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C3AED), Color(0xFF9333EA)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7C3AED).withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.card_giftcard_rounded, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'KOD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 11.5,
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
    );
  }

  void _showHeartDialog(
      BuildContext context, WidgetRef ref, int currentHearts, int currentGems,
      {bool isPremium = false}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        title: Row(
          children: [
            Icon(
              isPremium ? Icons.workspace_premium_rounded : Icons.favorite_rounded,
              color: isPremium ? const Color(0xFFD97706) : const Color(0xFFFF4B4B),
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              isPremium ? 'Super Premium 👑' : 'Can Durumu',
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isPremium) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: const Row(
                    children: [
                      Text('👑', style: TextStyle(fontSize: 22)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Sınırsız canın aktif! Yanlış yapsan da canın asla tükenmez.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF92400E),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE11D48),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.power_settings_new_rounded, color: Colors.white, size: 18),
                  label: const Text(
                    'Premium\'u Kapat (Canlı Moda Dön)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  onPressed: () {
                    ref.read(userProfileProvider.notifier).deactivatePremium();
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('❤️ Premium kapatıldı! 5 can ile normal canlı sisteme dönüldü.'),
                        backgroundColor: Color(0xFFE11D48),
                      ),
                    );
                  },
                ),
              ] else ...[
                Text(
                  'Mevcut Can: $currentHearts / 5',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFE11D48),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Her yanlış cevapta 1 can kaybedersin.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                ),
                const SizedBox(height: 16),

                // Can Doldur (50 Elmas)
                if (currentHearts < 5) ...[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0284C7),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.diamond_rounded, color: Colors.white, size: 20),
                    label: Text(
                      '50 Elmas İle Doldur ($currentGems 💎)',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    onPressed: () {
                      final success = ref
                          .read(userProfileProvider.notifier)
                          .refillHearts(withGems: true);
                      Navigator.pop(ctx);
                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Yeterli elmasınız yok! (50 Elmas gerekli)'),
                            backgroundColor: Color(0xFFFF4B4B),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                ],

                // Premium Al
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C3AED),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 20),
                  label: const Text(
                    'Premium Al (Sınırsız Can)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                    PremiumPurchaseSheet.show(context, ref);
                  },
                ),
              ],
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  Navigator.pop(ctx);
                  PromoCodeDialog.show(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F9FF),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFB9E6FE)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.card_giftcard_rounded, color: Color(0xFF1CB0F6), size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Promosyon Kodu Gir 🎁',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF1CB0F6),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Kapat', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _ModernStatChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Color borderColor;
  final String value;
  final String label;

  const _ModernStatChip({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.borderColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 5),
          Text(
            value,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
