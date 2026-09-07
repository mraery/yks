import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import 'promo_code_dialog.dart';

class StatsBar extends ConsumerWidget implements PreferredSizeWidget {
  const StatsBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E5E5), width: 2),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Streak
            _StatItem(
              icon: Icons.local_fire_department_rounded,
              iconColor: const Color(0xFFFF9600),
              value: '${profile.streak}',
              label: 'Gün',
            ),
            // Gems (tıklanabilir - Promosyon Kodu & Mağaza)
            InkWell(
              onTap: () => PromoCodeDialog.show(context),
              borderRadius: BorderRadius.circular(12),
              child: _StatItem(
                icon: Icons.diamond_rounded,
                iconColor: const Color(0xFF1CB0F6),
                value: '${profile.gems}',
                label: 'Elmas',
              ),
            ),
            // Hearts
            InkWell(
              onTap: () => _showHeartDialog(context, ref, profile.hearts, profile.gems),
              borderRadius: BorderRadius.circular(12),
              child: _StatItem(
                icon: Icons.favorite_rounded,
                iconColor: const Color(0xFFFF4B4B),
                value: '${profile.hearts}',
                label: 'Can',
              ),
            ),
            // Promosyon Kodu Butonu
            InkWell(
              onTap: () => PromoCodeDialog.show(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F9FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFB9E6FE), width: 1.5),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.card_giftcard_rounded, color: Color(0xFF1CB0F6), size: 18),
                    SizedBox(width: 4),
                    Text(
                      'KOD',
                      style: TextStyle(
                        color: Color(0xFF1CB0F6),
                        fontWeight: FontWeight.w900,
                        fontSize: 12.5,
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
      BuildContext context, WidgetRef ref, int currentHearts, int currentGems) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.favorite_rounded, color: Color(0xFFFF4B4B), size: 28),
            SizedBox(width: 8),
            Text('Canların', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Şu anki canın: $currentHearts / 5\n'
              'Her yanlış cevapta 1 can kaybedersin.',
              style: const TextStyle(fontSize: 15, color: Color(0xFF4B4B4B)),
            ),
            const SizedBox(height: 16),
            if (currentHearts < 5) ...[
              Text(
                '50 Elmas karşılığında canlarını tamamen doldurabilirsin (Mevcut: $currentGems Elmas).',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
            const SizedBox(height: 14),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.card_giftcard_rounded, color: Color(0xFF1CB0F6), size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Promosyon / Hile Kodu Gir 🎁',
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Kapat'),
          ),
          if (currentHearts < 5)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF58CC02),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
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
              child: const Text(
                'Can Doldur (50 💎)',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
