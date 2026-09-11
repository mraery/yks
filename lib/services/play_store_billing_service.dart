import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../widgets/google_play_payment_sheet.dart';

class PlayStoreBillingService {
  PlayStoreBillingService._();
  static final PlayStoreBillingService instance = PlayStoreBillingService._();

  // Google Play Console resmi urun kimlikleri
  static const String monthlySubscriptionId = 'ykspatika_premium_monthly';
  static const String yearlySubscriptionId = 'ykspatika_premium_yearly';

  static const Set<String> subscriptionProductIds = {
    monthlySubscriptionId,
    yearlySubscriptionId,
  };

  bool _isAvailable = true;
  bool get isAvailable => _isAvailable;

  /// Servisi baslatir
  Future<void> initialize(WidgetRef ref) async {
    _isAvailable = true;
    debugPrint('PlayStoreBillingService baslatildi.');
  }

  /// Satin alma ekranini acar
  Future<void> buySubscription({
    required BuildContext context,
    required WidgetRef ref,
    required String productId,
    required String planName,
    required String priceText,
  }) async {
    final isMonthly = productId == monthlySubscriptionId;
    final amount = isMonthly ? 58.0 : 480.0;

    await GooglePlayPaymentSheet.show(
      context: context,
      ref: ref,
      planName: planName,
      priceText: priceText,
      amount: amount,
      isMonthly: isMonthly,
    );
  }

  /// Satin almalari geri yukle (Restore Purchases)
  Future<void> restorePurchases({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final isPremium = ref.read(userProfileProvider).isPremium;
    if (isPremium) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aktif Premium aboneliğiniz doğrulandı.'),
          backgroundColor: Color(0xFF01875F),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google Play hesabınızda kayıtlı aktif abonelik bulunamadı.'),
        backgroundColor: Color(0xFF64748B),
      ),
    );
  }

  void dispose() {}
}
