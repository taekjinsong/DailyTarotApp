import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ad_service.dart';

class PurchaseService {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  static const String premiumMonthlyId = 'premium_monthly';
  static const String premiumYearlyId = 'premium_yearly';
  static const Set<String> _productIds = {premiumMonthlyId, premiumYearlyId};

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> products = [];
  bool _isPremium = false;
  final ValueNotifier<bool> premiumNotifier = ValueNotifier(false);

  bool get isPremium => _isPremium;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool('is_premium') ?? false;
    premiumNotifier.value = _isPremium;

    final available = await _iap.isAvailable();
    if (!available) return;

    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdated,
      onError: (error) {
        debugPrint('Purchase stream error: $error');
      },
    );

    await _loadProducts();
    await _restorePurchases();
  }

  Future<void> _loadProducts() async {
    final response = await _iap.queryProductDetails(_productIds);
    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('Products not found: ${response.notFoundIDs}');
    }
    products = response.productDetails;
  }

  Future<void> _restorePurchases() async {
    await _iap.restorePurchases();
  }

  Future<void> buyPremium({String productId = premiumMonthlyId}) async {
    final product = products.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw Exception('Product not found: $productId'),
    );
    final purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _activatePremium();
          if (purchase.pendingCompletePurchase) {
            _iap.completePurchase(purchase);
          }
          break;
        case PurchaseStatus.error:
          debugPrint('Purchase error: ${purchase.error}');
          break;
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.canceled:
          break;
      }
    }
  }

  Future<void> _activatePremium() async {
    _isPremium = true;
    premiumNotifier.value = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_premium', true);
    AdService().setPremium(true);
  }

  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  void dispose() {
    _subscription?.cancel();
    premiumNotifier.dispose();
  }
}
