import 'package:in_app_purchase/in_app_purchase.dart';

class BillingService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Future<void> initialize() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      // Handle the error when the store is not available
    }
  }

  Future<void> fetchSubscriptions() async {
    const Set<String> _kIds = {'premium_membership'}; // Your product IDs
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_kIds);
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error when products are not found
    }
    // Access the available products
    final List<ProductDetails> products = response.productDetails;
  }

  Future<void> purchaseSubscription(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void listenToPurchaseUpdates() {
    _inAppPurchase.purchaseStream.listen((List<PurchaseDetails> purchaseDetailsList) {
      _handlePurchaseUpdates(purchaseDetailsList);
    });
  }

  void _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        // Grant the user the subscription/premium features
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle the error
      }
    }
  }
}
