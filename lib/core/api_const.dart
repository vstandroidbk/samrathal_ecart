class ApiEndPoints {
  ApiEndPoints._();

  static const Map<String, dynamic> headerContent = {
    "Content-Type": "application/json",
  };
  static const String envType = "production";
  static const String baseUrl = "http://65.0.74.30/"; // development
  // static const String baseUrl = "https://crm.volansoft.in/"; // production

  static const String checkUserType = "check-user-type";
  static const String verifyOtp = "verify-otp";
  static const String verifyPassword = "login-by-password";
  static const String resendOtpOtp = "resend-otp";
  static const String registerUser = "register-user";
  static const String forgotPassword = "forgot-password";
  static const String changePassword = "change-password";
  static const String addAddress = "add-address-details";
  static const String updateAddress = "update-address-data";
  static const String updatePrimaryAddress = "update-primary-status";
  static const String getCity = "get-district-list";
  static const String getState = "get-state-list";
  static const String getAddressList = "get-address-list";
  static const String getEditAddressData = "get-edit-address-data";
  static const String getProfileData = "get-profile-data";
  static const String getDashboardData = "get-dashboard-data";
  static const String getProductListData = "get-product-list";
  static const String getProductDetailsData = "get-product-details";
  static const String getOfferListData = "get-offer-list";
  static const String getOfferDetailsData = "get-offer-details";

  static const String addProductToCart = "add-to-cart";
  static const String listCartItem = "list-cart-item";
  static const String getCartItemDetails = "get-item-details";
  static const String updateCartItem = "update-cart-item";
  static const String removeCartItem = "remove-cart-item";
  static const String paymentMethodLIst = "payment-list";
  static const String uploadScreenshot = "app-image-upload";
  static const String orderPlaced = "order-placed";

  static const String orderListData = "order-list";
  static const String orderDetails = "order-details";
  static const String orderItemDetails = "order-item-details";

  static const String orderPaymentList = "order-payment-list";
  static const String orderPaymentDetails = "order-payment-details";
  static const String orderReceiveVerify = "order-receive-verify";
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}
