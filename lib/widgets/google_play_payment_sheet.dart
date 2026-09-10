import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../services/sound_service.dart';

class GooglePlayPaymentSheet extends StatefulWidget {
  final WidgetRef ref;
  final String planName;
  final String priceText;
  final double amount;
  final bool isMonthly;

  const GooglePlayPaymentSheet({
    super.key,
    required this.ref,
    required this.planName,
    required this.priceText,
    required this.amount,
    required this.isMonthly,
  });

  static Future<bool?> show({
    required BuildContext context,
    required WidgetRef ref,
    required String planName,
    required String priceText,
    required double amount,
    required bool isMonthly,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => GooglePlayPaymentSheet(
        ref: ref,
        planName: planName,
        priceText: priceText,
        amount: amount,
        isMonthly: isMonthly,
      ),
    );
  }

  @override
  State<GooglePlayPaymentSheet> createState() => _GooglePlayPaymentSheetState();
}

class _GooglePlayPaymentSheetState extends State<GooglePlayPaymentSheet> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController(text: '5258 4582 1920 3481');
  final _cardHolderController = TextEditingController(text: 'Ahmet Yilmaz');
  final _expiryController = TextEditingController(text: '08/28');
  final _cvvController = TextEditingController(text: '342');

  bool _useSavedCard = true;
  bool _isProcessing = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _processPayment() async {
    if (!_useSavedCard && !(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isProcessing = true);

    // Google Play Baglanti & Banka 3D Secure Simülasyonu
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    // 3D Secure SMS Onay Dialogu
    final smsApproved = await _show3DSecureDialog();

    if (!mounted) return;

    if (smsApproved == true) {
      // Basarili odeme
      widget.ref.read(userProfileProvider.notifier).activatePremium();
      SoundService.playComplete();

      Navigator.of(context).pop(true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Google Play: ${widget.planName} Basariyla Odendi! Sinirsiz caniniz aktif.',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF01875F),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
    } else {
      setState(() => _isProcessing = false);
    }
  }

  Future<bool?> _show3DSecureDialog() {
    final smsCodeController = TextEditingController(text: '584291');

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        actionsPadding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        title: const Row(
          children: [
            Icon(Icons.security_rounded, color: Color(0xFF01875F), size: 26),
            SizedBox(width: 10),
            Text(
              'Banka 3D Secure Onayi',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'YKS Patika ${widget.planName} icin ${widget.priceText} tutarinda odeme yapilacaktir.',
              style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SMS Dogrulama Kodu:',
                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Telefonunuza 6 haneli banka onay kodu gonderildi.',
                    style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: smsCodeController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                color: Color(0xFF01875F),
              ),
              decoration: InputDecoration(
                hintText: '123456',
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF01875F), width: 2),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Iptal', style: TextStyle(color: Color(0xFF94A3B8))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF01875F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'ONAYLA VE ODE',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.92,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Handle Bar
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Google Play Baslik
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0FE),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.shop_rounded, color: Color(0xFF01875F), size: 28),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Google Play Odeme',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF202124),
                            ),
                          ),
                          Text(
                            '256-bit SSL Guvenli Kart & Fatura Altyapisi',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF5F6368),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Plan Ozeti Kutusu
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFEF3C7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.workspace_premium_rounded, color: Color(0xFFD97706), size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'YKS Patika ${widget.planName}',
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                            ),
                            const Text(
                              'Sinirsiz Can • Tum Konular Acik • Sifir Reklam',
                              style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.priceText,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF01875F),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Odeme Yontemi Secimi: Kayitli Google Karti veya Yeni Kart
                const Text(
                  'ODEME YONTEMI',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF64748B),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),

                // 1. Secenek: Google Hesabinda Kayitli Kart
                InkWell(
                  onTap: () => setState(() => _useSavedCard = true),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _useSavedCard ? const Color(0xFFF0FDF4) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _useSavedCard ? const Color(0xFF01875F) : const Color(0xFFCBD5E1),
                        width: _useSavedCard ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _useSavedCard ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                          color: _useSavedCard ? const Color(0xFF01875F) : const Color(0xFF94A3B8),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.credit_card_rounded, color: Color(0xFF1E293B), size: 26),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Google Kayitli Kartim (Mastercard •••• 3481)',
                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
                              ),
                              Text(
                                'Google Play hesabinizla 1 tikla guvenli odeyin',
                                style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // 2. Secenek: Yeni Kart Girisi
                InkWell(
                  onTap: () => setState(() => _useSavedCard = false),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: !_useSavedCard ? const Color(0xFFF0FDF4) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: !_useSavedCard ? const Color(0xFF01875F) : const Color(0xFFCBD5E1),
                        width: !_useSavedCard ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          !_useSavedCard ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                          color: !_useSavedCard ? const Color(0xFF01875F) : const Color(0xFF94A3B8),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.add_card_rounded, color: Color(0xFF1E293B), size: 26),
                        const SizedBox(width: 10),
                        const Text(
                          'Yeni Kredi / Banka Karti Ekle',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
                        ),
                      ],
                    ),
                  ),
                ),

                // Yeni Kart Formu (Secildiyse goster)
                if (!_useSavedCard) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'KART BILGILERI',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF64748B)),
                        ),
                        const SizedBox(height: 10),

                        // Kart Sahibi
                        TextFormField(
                          controller: _cardHolderController,
                          decoration: InputDecoration(
                            labelText: 'Kart Uzerindeki Isim',
                            prefixIcon: const Icon(Icons.person_outline_rounded, size: 20),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (val) => (val == null || val.isEmpty) ? 'Isim girin' : null,
                        ),
                        const SizedBox(height: 10),

                        // Kart Numarasi
                        TextFormField(
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Kart Numarasi',
                            prefixIcon: const Icon(Icons.credit_card_rounded, size: 20),
                            hintText: '0000 0000 0000 0000',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          validator: (val) => (val == null || val.length < 16) ? 'Gecerli kart no girin' : null,
                        ),
                        const SizedBox(height: 10),

                        // SKT ve CVV
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _expiryController,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  labelText: 'SKT (AA/YY)',
                                  hintText: '12/28',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                validator: (val) => (val == null || val.length < 5) ? 'AA/YY girin' : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _cvvController,
                                keyboardType: TextInputType.number,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'CVV / CVC',
                                  hintText: '123',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                validator: (val) => (val == null || val.length < 3) ? '3 hane' : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                // Guvenlik Notu
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_rounded, size: 14, color: Color(0xFF64748B)),
                    SizedBox(width: 6),
                    Text(
                      'Google Play 256-bit SSL & 3D Secure Korumali',
                      style: TextStyle(fontSize: 11.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Satın Alma Butonu
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF01875F), // Google Play Yesil
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                  ),
                  onPressed: _isProcessing ? null : _processPayment,
                  child: _isProcessing
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                        )
                      : Text(
                          'GUVENLI ODE (${widget.priceText})',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                ),
                const SizedBox(height: 8),

                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Vazgec', style: TextStyle(color: Color(0xFF94A3B8))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
