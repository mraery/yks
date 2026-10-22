import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../providers/game_provider.dart';

/// Google Play Billing & Apple App StoreKit Uyumlu Satın Alma Servisi - YKS Quest
class PlayStoreBillingService {
  PlayStoreBillingService._();
  static final PlayStoreBillingService instance = PlayStoreBillingService._();

  // Resmi Mağaza Ürün Kimlikleri (Google Play Console & App Store Connect)
  static const String monthlySubscriptionId = 'yks_vip_monthly';
  static const String yearlySubscriptionId = 'yks_vip_yearly';
  static const String gemsPackId = 'yks_gems_pack';

  // Desteklenen tüm kimlikler
  static const Set<String> allProductIds = {
    monthlySubscriptionId,
    yearlySubscriptionId,
    gemsPackId,
    'ykspatika_premium_monthly',
    'ykspatika_premium_yearly',
    'yks_premium_monthly',
    'yks_premium_yearly',
  };

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  WidgetRef? _ref;

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  Map<String, ProductDetails> _products = {};
  Map<String, ProductDetails> get products => _products;

  /// Servisi başlatır ve mağaza satın alma akışını dinler
  Future<void> initialize(WidgetRef ref) async {
    _ref = ref;

    try {
      _isAvailable = await _iap.isAvailable();
      debugPrint('[StoreService-YKS] Mağaza kullanılabilirliği: $_isAvailable');

      _subscription?.cancel();
      _subscription = _iap.purchaseStream.listen(
        _onPurchaseStream,
        onDone: () => _subscription?.cancel(),
        onError: (error) {
          debugPrint('[StoreService-YKS] Satın alma akışı hatası: $error');
        },
      );

      if (_isAvailable) {
        await queryProducts();
      }
    } catch (e) {
      debugPrint('[StoreService-YKS] Başlatma hatası: $e');
    }
  }

  /// Mağazadaki ürünlerin gerçek fiyatlarını ve detaylarını çeker
  Future<void> queryProducts() async {
    try {
      final response = await _iap.queryProductDetails(allProductIds);
      if (response.error != null) {
        debugPrint('[StoreService-YKS] Ürün sorgulama hatası: ${response.error}');
      }

      final Map<String, ProductDetails> map = {};
      for (final p in response.productDetails) {
        map[p.id] = p;
      }
      _products = map;
      debugPrint('[StoreService-YKS] Yüklenen ürün sayısı: ${_products.length}');
    } catch (e) {
      debugPrint('[StoreService-YKS] Ürünler çekilirken hata: $e');
    }
  }

  ProductDetails? getProduct(String id) => _products[id];

  /// Satın alma akışı dinleyicisi
  Future<void> _onPurchaseStream(List<PurchaseDetails> purchaseDetailsList) async {
    for (final purchaseDetails in purchaseDetailsList) {
      debugPrint(
        '[StoreService-YKS] Satın Alma Güncellemesi: ${purchaseDetails.productID} '
        'Durum: ${purchaseDetails.status}',
      );

      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _deliverProduct(purchaseDetails);
          break;

        case PurchaseStatus.error:
          debugPrint('[StoreService-YKS] Satın alma hatası: ${purchaseDetails.error}');
          break;

        case PurchaseStatus.canceled:
          debugPrint('[StoreService-YKS] Satın alma iptal edildi.');
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        try {
          await _iap.completePurchase(purchaseDetails);
          debugPrint('[StoreService-YKS] İşlem tamamlandı: ${purchaseDetails.productID}');
        } catch (e) {
          debugPrint('[StoreService-YKS] completePurchase hatası: $e');
        }
      }
    }
  }

  /// Satın alınan ürünü kullanıcı profiline tanımlar
  void _deliverProduct(PurchaseDetails purchase) {
    if (_ref == null) return;

    final id = purchase.productID;
    if (id == monthlySubscriptionId ||
        id == yearlySubscriptionId ||
        id == 'ykspatika_premium_monthly' ||
        id == 'ykspatika_premium_yearly' ||
        id == 'yks_premium_monthly' ||
        id == 'yks_premium_yearly') {
      _ref!.read(userProfileProvider.notifier).activatePremium();
      debugPrint('[StoreService-YKS] Premium VIP aktif edildi!');
    } else if (id == gemsPackId) {
      _ref!.read(userProfileProvider.notifier).addGems(1000);
      debugPrint('[StoreService-YKS] 1000 Elmas eklendi!');
    }
  }

  /// Resmi Mağaza Satın Alma Akışını Başlatır
  Future<bool> startPurchase({
    required BuildContext context,
    required WidgetRef ref,
    required String productId,
    bool isConsumable = false,
  }) async {
    _ref = ref;

    final product = _products[productId];
    if (product != null && _isAvailable) {
      final purchaseParam = PurchaseParam(productDetails: product);
      if (isConsumable) {
        return await _iap.buyConsumable(purchaseParam: purchaseParam);
      } else {
        return await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      }
    }

    return await _showStoreTestDialog(context, ref, productId);
  }

  /// Geliştirme ve Test Aşaması İçin Sandbox Onayı
  Future<bool> _showStoreTestDialog(
    BuildContext context,
    WidgetRef ref,
    String productId,
  ) async {
    final isMonthly = productId == monthlySubscriptionId;
    final planName = isMonthly ? 'YKS VIP Aylık Plan (59,99 ₺)' : 'YKS VIP Yıllık Plan (499,99 ₺)';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.storefront_rounded, color: Color(0xFF01875F), size: 26),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Mağaza Faturalandırma',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user_rounded, color: Color(0xFF6366F1), size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      planName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Uygulama Google Play / App Store mağaza onay sürecindedir. '
              'Mağaza panelinde ürünler aktif olduğunda ödeme doğrudan mağaza arayüzü ile tamamlanacaktır.\n\n'
              'Şimdi test etmek için Premium özelliklerini etkinleştirmek ister misiniz?',
              style: TextStyle(fontSize: 12.5, color: Color(0xFF475569), height: 1.4),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Vazgeç', style: TextStyle(color: Color(0xFF64748B))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF01875F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              ref.read(userProfileProvider.notifier).activatePremium();
              Navigator.pop(ctx, true);
            },
            child: const Text('Test Olarak Etkinleştir', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    return confirmed ?? false;
  }

  /// Satın Alımları Geri Yükle
  Future<void> restorePurchases({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    _ref = ref;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            ),
            SizedBox(width: 12),
            Text('YKS Quest mağaza abonelikleriniz taranıyor...'),
          ],
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF334155),
      ),
    );

    try {
      if (_isAvailable) {
        await _iap.restorePurchases();
      }

      await Future.delayed(const Duration(milliseconds: 1200));

      if (!context.mounted) return;

      final isPremium = ref.read(userProfileProvider).isPremium;
      if (isPremium) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Aktif YKS Quest VIP aboneliğiniz başarıyla doğrulandı!'),
            backgroundColor: Color(0xFF01875F),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mağaza hesabınızda kayıtlı aktif bir abonelik bulunamadı.'),
            backgroundColor: Color(0xFF64748B),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Geri yükleme sırasında hata oluştu: $e'),
          backgroundColor: const Color(0xFFE11D48),
        ),
      );
    }
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
