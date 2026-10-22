import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/play_store_billing_service.dart';
import 'promo_code_dialog.dart';

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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isMonthly = _selectedPlan == 'monthly';
    final billing = PlayStoreBillingService.instance;

    final monthlyProduct = billing.getProduct(PlayStoreBillingService.monthlySubscriptionId);
    final yearlyProduct = billing.getProduct(PlayStoreBillingService.yearlySubscriptionId);

    final monthlyPrice = monthlyProduct?.price ?? '59,99 ₺';
    final yearlyPrice = yearlyProduct?.price ?? '499,99 ₺';

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.92,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 12),
              const Text(
                'YKS Quest Super VIP 👑',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFC7D2FE)),
                ),
                child: const Text(
                  'SINIRSIZ CAN & SIFIR REKLAM',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF4338CA),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              _buildPerkRow(
                icon: Icons.all_inclusive_rounded,
                iconColor: const Color(0xFFE11D48),
                title: 'Sınırsız Can (Hearts)',
                desc: 'TYT - AYT soru çözerken canın bitmeden aralıksız pratik yap.',
              ),
              const SizedBox(height: 12),
              _buildPerkRow(
                icon: Icons.block_rounded,
                iconColor: const Color(0xFF6366F1),
                title: '%100 Reklamsız Çalışma',
                desc: 'Hiçbir reklam araya girmeden yüksek konsantrasyonla soru çöz.',
              ),
              const SizedBox(height: 12),
              _buildPerkRow(
                icon: Icons.bolt_rounded,
                iconColor: const Color(0xFFF59E0B),
                title: '2x Hızlı İlerleme & Seviye Atlama',
                desc: 'Liderlik tablosunda YKS rakiplerinin önüne kolayca geç.',
              ),
              const SizedBox(height: 12),
              _buildPerkRow(
                icon: Icons.lock_open_rounded,
                iconColor: const Color(0xFF10B981),
                title: 'Tüm TYT-AYT Konu Modülleri',
                desc: 'Türkçe, Matematik, Tarih, Coğrafya ve Felsefe ünitelerine anında erişim.',
              ),
              const SizedBox(height: 20),

              _buildPlanCard(
                title: 'Yıllık VIP Plan',
                price: yearlyPrice,
                period: '/ yıl',
                subtitle: 'Aylık sadece ${(499.99 / 12).toStringAsFixed(1)} ₺ • Tek çekim',
                badgeText: '%31 TASARRUF • EN POPÜLER 🌟',
                isSelected: !isMonthly,
                onTap: () => setState(() => _selectedPlan = 'yearly'),
              ),
              const SizedBox(height: 10),
              _buildPlanCard(
                title: 'Aylık VIP Plan',
                price: monthlyPrice,
                period: '/ ay',
                subtitle: 'İstediğin zaman mağazadan iptal edebilirsin',
                badgeText: null,
                isSelected: isMonthly,
                onTap: () => setState(() => _selectedPlan = 'monthly'),
              ),
              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.verified_rounded, color: Color(0xFF01875F), size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Google Play & Apple Güvenli Faturalandırma',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    elevation: 3,
                    shadowColor: const Color(0xFF6366F1).withOpacity(0.4),
                  ),
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 22),
                  label: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _isLoading
                          ? 'İşlem Başlatılıyor...'
                          : isMonthly
                              ? 'Abone Ol ($monthlyPrice / ay)'
                              : 'Abone Ol ($yearlyPrice / yıl)',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() => _isLoading = true);
                          final productId = isMonthly
                              ? PlayStoreBillingService.monthlySubscriptionId
                              : PlayStoreBillingService.yearlySubscriptionId;

                          final nav = Navigator.of(context);
                          final success = await billing.startPurchase(
                            context: context,
                            ref: widget.ref,
                            productId: productId,
                          );

                          if (mounted) {
                            setState(() => _isLoading = false);
                            if (success) {
                              nav.pop(true);
                            }
                          }
                        },
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.restore_rounded, size: 16, color: Color(0xFF64748B)),
                    label: const Text(
                      'Satın Alımları Geri Yükle',
                      style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    onPressed: () {
                      billing.restorePurchases(
                        context: context,
                        ref: widget.ref,
                      );
                    },
                  ),
                  const Text(' • ', style: TextStyle(color: Color(0xFFCBD5E1))),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      PromoCodeDialog.show(context);
                    },
                    child: const Text(
                      'Kod Kullan',
                      style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              const Text(
                'Abonelikler, cari dönemin bitiminden en az 24 saat önce iptal edilmediği sürece otomatik olarak yenilenir. '
                'Satın alma sonrasında Google Play / Apple ID hesap ayarlarınızdan aboneliğinizi dilediğiniz an yönetebilir veya iptal edebilirsiniz.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF94A3B8),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegalLink('Gizlilik Politikası', () => _showLegalDialog('Gizlilik Politikası', 'YKS Quest kullanıcı gizliliğine tam saygı duyar. Kişisel ödeme bilgileriniz Google Play ve Apple StoreKit güvenli altyapısı üzerinden işlenir.')),
                  const Text(' • ', style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 11)),
                  _buildLegalLink('Kullanım Koşulları', () => _showLegalDialog('Kullanım Koşulları', 'YKS Quest VIP üyeliği YKS hazırlık içeriklerine sınırsız can ve reklamsız erişim sağlar. Standart Apple EULA ve Google Play Hizmet Koşulları geçerlidir.')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegalLink(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10.5,
          color: Color(0xFF64748B),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  void _showLegalDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        content: Text(content, style: const TextStyle(fontSize: 13, height: 1.4, color: Color(0xFF334155))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String period,
    required String subtitle,
    required String? badgeText,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF2FF) : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : const Color(0xFFE2E8F0),
            width: isSelected ? 2 : 1,
          ),
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
                  color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF94A3B8),
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
                          color: isSelected ? const Color(0xFF4338CA) : const Color(0xFF1E293B),
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
                        color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF1E293B),
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
