import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';

class PromoCodeDialog extends ConsumerStatefulWidget {
  const PromoCodeDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => const PromoCodeDialog(),
    );
  }

  @override
  ConsumerState<PromoCodeDialog> createState() => _PromoCodeDialogState();
}

class _PromoCodeDialogState extends ConsumerState<PromoCodeDialog> {
  final TextEditingController _controller = TextEditingController();
  PromoResult? _result;
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _applyCode([String? predefinedCode]) {
    final codeToApply = predefinedCode ?? _controller.text;
    if (codeToApply.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _result = null;
    });

    final result = ref.read(userProfileProvider.notifier).applyPromoCode(codeToApply);

    setState(() {
      _isLoading = false;
      _result = result;
      if (predefinedCode != null) {
        _controller.text = predefinedCode;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 12,
      child: Container(
        padding: const EdgeInsets.all(22),
        constraints: const BoxConstraints(maxWidth: 420),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Başlık
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1CB0F6).withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.card_giftcard_rounded,
                      color: Color(0xFF1CB0F6),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Promosyon Kodu',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF4B4B4B),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'İndirim veya hediye kodunu gir',
                          style: TextStyle(fontSize: 12.5, color: Color(0xFF777777)),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.grey),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Kod Giriş Alanı
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E5E5), width: 1.5),
                ),
                child: TextField(
                  controller: _controller,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Örn: YKS2026 veya INDIRIM50',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
                    prefixIcon: const Icon(Icons.local_offer_rounded, color: Color(0xFF1CB0F6)),
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 20),
                            onPressed: () {
                              _controller.clear();
                              setState(() => _result = null);
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onSubmitted: (_) => _applyCode(),
                ),
              ),

              const SizedBox(height: 12),

              // Hızlı Kod Butonları (Örnek Kodlar)
              const Text(
                'Örnek Kodlar:',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF888888),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: [
                  _buildCodeChip(
                    code: 'YKS2026',
                    label: '🎁 YKS2026 (+150 💎 & Can Yenile)',
                    badgeColor: const Color(0xFF1CB0F6),
                  ),
                  _buildCodeChip(
                    code: 'TAMPUAN',
                    label: '🏆 TAMPUAN (+200 💎 & XP)',
                    badgeColor: const Color(0xFF58CC02),
                  ),
                ],
              ),

              // Sonuç Bildirimi
              if (_result != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _result!.success
                        ? (_result!.isCheat
                            ? const Color(0xFFFFF3E0)
                            : const Color(0xFFE8F5E9))
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _result!.success
                          ? (_result!.isCheat
                              ? const Color(0xFFFF9600)
                              : const Color(0xFF58CC02))
                          : const Color(0xFFFF4B4B),
                      width: 1.8,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        _result!.success
                            ? (_result!.isCheat
                                ? Icons.whatshot_rounded
                                : Icons.check_circle_rounded)
                            : Icons.error_outline_rounded,
                        color: _result!.success
                            ? (_result!.isCheat
                                ? const Color(0xFFFF9600)
                                : const Color(0xFF58CC02))
                            : const Color(0xFFFF4B4B),
                        size: 26,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _result!.message,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: _result!.success
                                ? (_result!.isCheat
                                    ? const Color(0xFFE65100)
                                    : const Color(0xFF2E7D32))
                                : const Color(0xFFC62828),
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 20),

              // Uygula Butonu
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF58CC02),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                ),
                onPressed: _isLoading ? null : () => _applyCode(),
                child: _isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text(
                        'KODU UYGULA',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeChip({
    required String code,
    required String label,
    required Color badgeColor,
  }) {
    return InkWell(
      onTap: () => _applyCode(code),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: badgeColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: badgeColor.withOpacity(0.4), width: 1.2),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            color: badgeColor,
          ),
        ),
      ),
    );
  }
}
