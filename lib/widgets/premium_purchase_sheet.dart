import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/play_store_billing_service.dart';
import 'google_play_payment_sheet.dart';

class PremiumPurchaseSheet extends StatefulWidget {
  final WidgetRef ref;

  const PremiumPurchaseSheet({super.key, required this.ref});

  static Future<bool?> show(BuildContext context, WidgetRef ref) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => PremiumPurchaseSheet(ref: ref),
    );
  }

  @override
  State<PremiumPurchaseSheet> createState() => _PremiumPurchaseSheetState();
}

class _PremiumPurchaseSheetState extends State<PremiumPurchaseSheet> {
  String _selectedPlan = 'yearly'; // 'monthly' | 'yearly'

  @override
  Widget build(BuildContext context) {
    final isMonthly = _selectedPlan == 'monthly';

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.90,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 18),

              // Header Icon & Title
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 12),
              const Text(
                'YKS Lingo Super Premium 👑',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: const Text(
                  'SINIRSIZ CAN & SIFIR REKLAM',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF92400E),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Perks List
              _buildPerkRow(
                icon: Icons.all_inclusive_rounded,
                iconColor: const Color(0xFFE11D48),
                title: 'Sınırsız Can',
                desc: 'Yanlış cevap versen de canın asla azalmaz, dersten atılmazsın.',
              ),
              const SizedBox(height: 10),
              _buildPerkRow(
                icon: Icons.block_rounded,
                iconColor: const Color(0xFF7C3AED),
                title: 'Sıfır Reklam',
                desc: 'Soru aralarında veya ders sonlarında hiçbir reklam görmezsin.',
              ),
              const SizedBox(height: 10),
              _buildPerkRow(
                icon: Icons.menu_book_rounded,
                iconColor: const Color(0xFF0284C7),
                title: 'Tüm Konular & Kupa Sınavları',
                desc: '79 ünite ve 243 dersin tamamına sınırsız tam erişim.',
              ),
              const SizedBox(height: 22),

              // Plan Seçenekleri (Aylık 58 TL veya Yıllık 480 TL)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bir Plan Seç:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF334155),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // 1. AYLIK SEÇENEK (58 TL)
              _buildPlanCard(
                title: 'Aylık Plan',
                price: '58 ₺',
                period: '/ ay',
                subtitle: 'Her ay yenilenir • Dilediğin an iptal et',
                isSelected: isMonthly,
                onTap: () => setState(() => _selectedPlan = 'monthly'),
              ),
              const SizedBox(height: 10),

              // 2. YILLIK SEÇENEK (480 TL)
              _buildPlanCard(
                title: 'Yıllık Plan',
                price: '480 ₺',
                period: '/ yıl',
                subtitle: 'Aylık sadece 40 ₺ • Tek ödeme',
                badgeText: '%31 TASARRUF • EN POPÜLER 🌟',
                isSelected: !isMonthly,
                onTap: () => setState(() => _selectedPlan = 'yearly'),
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 20),

              // Google Play Güvenli Ödeme Rozeti
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shop_rounded, color: Color(0xFF01875F), size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Google Play Güvenli Faturalandırma Altyapısı',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Google Play ile Satın Alma / Başlat Butonu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF01875F), // Google Play Yeşil
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    elevation: 4,
                    shadowColor: const Color(0xFF01875F).withOpacity(0.4),
                  ),
                  icon: const Icon(Icons.shop_rounded, color: Colors.white, size: 22),
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      isMonthly
                          ? 'Google Play ile Abone Ol (58 ₺ / ay)'
                          : 'Google Play ile Abone Ol (480 ₺ / yıl)',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final paid = await GooglePlayPaymentSheet.show(
                      context: context,
                      ref: widget.ref,
                      planName: isMonthly ? 'Aylık Plan' : 'Yıllık Plan',
                      priceText: isMonthly ? '58 ₺ / ay' : '480 ₺ / yıl',
                      amount: isMonthly ? 58.0 : 480.0,
                      isMonthly: isMonthly,
                    );
                    if (paid == true && context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Satın Almaları Geri Yükle & Vazgeç
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.restore_rounded, size: 16, color: Color(0xFF64748B)),
                    label: const Text(
                      'Aboneliği Geri Yükle',
                      style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    onPressed: () {
                      PlayStoreBillingService.instance.restorePurchases(
                        context: context,
                        ref: widget.ref,
                      );
                    },
                  ),
                  const Text(' • ', style: TextStyle(color: Color(0xFFCBD5E1))),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'Vazgeç',
                      style: TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Dilediğiniz an Google Play Store > Abonelikler menüsünden iptal edebilirsiniz.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.5, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String period,
    required String subtitle,
    String? badgeText,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF5F3FF) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? const Color(0xFF7C3AED) : const Color(0xFFE2E8F0),
            width: isSelected ? 2.2 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (badgeText != null) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
            Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                  color: isSelected ? const Color(0xFF7C3AED) : const Color(0xFF94A3B8),
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w900,
                          color: isSelected ? const Color(0xFF4C1D95) : const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: isSelected ? const Color(0xFF7C3AED) : const Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      period,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerkRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String desc,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13.5,
                  color: Color(0xFF1E293B),
                ),
              ),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF64748B),
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
