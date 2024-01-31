import 'app_images.dart';

class AppStrings {
  AppStrings._();

  static String appName = "Samrathal";
  static String noInternet =
      "Oops! It looks like you're not connected to the internet."
      " 🌐 Please check your connection and try again.";
  static String mobileVerifyScreenTitle = "Mobile Verification";
  static String passwordVerifyScreenTitle = "Password Verification";
  static String otpVerifyScreenTitle = "OTP Verification";
  static String forgotPasswordScreenTitle = "Forgot Password";
  static String newPasswordScreenTitle = "Set New Password";
  static String registerScreenTitle = "Sign Up";
  static String fillDetailsScreenTitle = "Fill Details";
  static String phoneNumberLabel = "Enter Mobile";
  static String passwordLabel = "Enter Password";
  static String otpLabel = "Enter OTP";
  static String newPasswordLabel = "New Password";
  static String oldPasswordLabel = "Old Password";
  static String cnfPasswordLabel = "Confirm Password";
  static String nameLabel = "Enter Name";
  static String stateLabel = "Select State";
  static String cityLabel = "Select City";
  static String addressLabel = "Address";
  static String landmarkLabel = "Landmark";
  static String zipLabel = "Zip/Postal Code";

  static String companyNameLabel = "Company Name";
  static String gstNumberLabel = "GST Number";
  static String billingAddressLabel = "Billing Address";

  static String mobileHint = "Enter your Mobile Number";
  static String passwordHint = "Enter your Password";
  static String newPasswordHint = "Enter New Password";
  static String oldPasswordHint = "Enter Old Password";
  static String cnfPasswordHint = "Enter Confirm Password";
  static String nameHint = "Enter your Name";
  static String addressHint = "Enter your address";
  static String landmarkHint = "Enter Landmark";
  static String zipHint = "Enter your Zip/Postal code";

  static String companyNameHint = "Enter your company name";
  static String gstNumberHint = "Enter your GST number";
  static String billingAddressHint = "Enter your Billing Address";

  static String verifyMobileInnerTxt = "Let's Get Started";

  static String submitTxt = "Submit";
  static String continueTxt = "Continue";
  static String nextTxt = "Next";
  static String verifyTxt = "Verify";
  static String forgotPasswordTxt = "Forgot Password?";
  static String loginWithOtpTxt = "Login with OTP";
  static String resendOtpTxt = "Resend OTP";

  static String individualTxt = "Individual";
  static String companyTxt = "Company";

  static String homeTabTxt = "Home";
  static String shopTabTxt = "Shop";
  static String cartTabTxt = "Cart";
  static String wishlistTabTxt = "Favourite";
  static String profileTabTxt = "Profile";

  static String seeAllTxt = "See All";
  static String offersTxt = "Offers";
  static String productsTxt = "Products";

  static String addressTxt = "Address";
  static String orderTxt = "Order";
  static String paymentTxt = "Payment";
  static String helpTxt = "Help";
  static String supportTxt = "Support";
  static String logoutTxt = "Log Out";

  static String changePassTxt = "Change Password";
  static String addAddressTxt = "Add Address";
  static String editAddressTxt = "Edit Address";
  static String picLocationTxt = "Pick Location";
  static String shopNowTxt = "Shop Now";
  static String noOrderTxt = "No Orders Yet";

  static String receiveNowTxt = "Receive now";
  static String payNowTxt = "Pay Now";

  static String orderItemTxt = "Order Items";
  static String shipAddressTxt = "Shipping Address";

  static String fromLoginScreen = "From Login Screen";
  static String fromVerifyMobileScreen = "From Verify Mobile";
  static String fromRegisterScreen = "From Register Screen";
  static String fromForgetScreen = "From Forget Screen";
  static String fromOrderScreen = "From Order Screen";
  static String fromOtpScreen = "From otp Screen";

  static String paymentListTxt = "Payment List";
  static String paymentDetailsTxt = "Payment Details";
  static String paymentMethodTxt = "Payment Method";

  static String paymentIdTxt = "Payment Id";
  static String orderIdTxt = "Order Id";
  static String paymentDateTxt = "Payment Date";
  static String paymentStatusTxt = "Status";
  static String paymentAmtTxt = "Amount";

  static String bankAcTxt = "Bank A/C";
  static String upiTxt = "UPI";
  static String qrTxt = "QR Code";

  static String acNumberTxt = "Account Number";
  static String ifscCodeTxt = "IFSC Code";
  static String micrCodeTxt = "MICR Code";
  static String bankNameTxt = "Bank Name";
  static String branchNameTxt = "Branch";
  static String acHolderName = "Ac Holder Name";
  static String totalOrderAmtTxt = "Total Order Amount";
  static String outStandingAmtTxt = "Outstanding Amount";
  static String paidViaTxt = "Paid Via";
  static String uploadScreenshotTxt = "Upload Screenshot";
  static String amtPaidTxt = "Amount Paid";
  static String amtHintTxt = "Enter Amount";

  static String productDetailsTxt = "Product Details";
  static String packingSizeTxt = "Packing Size";
  static String descriptionTxt = "Description";
  static String addToCartTxt = "Add To Cart";
  static String addedToCartTxt = "Added To Cart";
  static String quantityTxt = "Enter random qty";
  static String totalQuantityTxt = "Total Quantity";
  static String checkoutTxt = "Checkout";
  static String cartItemsTxt = "Cart Items";

  static String startDateTxt = "Start Date";
  static String endDateTxt = "End Date";
  static String offerTitleTxt = "Offer Title";
  static String optOfferTxt = "Yes i opt this offer";

  static String verifyMobileTitle = "Welcome Back!";
  static String verifyMobileDesc = "Hey Good to see you again..";
  static String verifyOtpTitle = "Verify OTP";
  static String verifyOtpDesc = "Enter OTP we have sent to";
  static String verifyPasswordTitle = "Verify Password";
  static String verifyPasswordDesc =
      "Enter Your Password to verify your account";
  static String forgotPasswordTitle = "Forgot Password";
  static String forgotPasswordDesc =
      "Enter Mobile number to forgot your password";
  static String newPasswordTitle = "New Password";
  static String newPasswordDesc = "Set your new password";

  static String areYouSureTxt = "Are you sure, do you want to logout?";
  static String successTxt = "SUCCESS";

  static String fromCart = "From Cart";
  static String fromPaymentList = "From Payment List";
  static String fromOrderList = "From Payment List";
}

final List<Map<String, String>> productList = [
  {
    "img": AppImages.product2,
    "name": "Wire Packs",
    "sku": "ABC-123",
  },
  {
    "img": AppImages.product1,
    "name": "Black wire",
    "sku": "BCD-123",
  },
  {
    "img": AppImages.product2,
    "name": "Wire Packs",
    "sku": "DEF-123",
  },
  {
    "img": AppImages.product1,
    "name": "Black wire",
    "sku": "GHI-123",
  },
  {
    "img": AppImages.product1,
    "name": "Wire Packs",
    "sku": "KLM-123",
  },
];

List<Map<String, dynamic>> dropDownList = [
  {"id": "all", "status": "All Order"},
  {"id": "0", "status": "Order Placed"},
  {"id": "1", "status": "Order confirmed"},
  {"id": "2", "status": "Order packed"},
  {"id": "3", "status": "Order on its way"},
  {"id": "4", "status": "Order out for delivery"},
  {"id": "5", "status": "Order delivered"},
];

List<Map<String, dynamic>> paymentStatusList = [
  {"id": "all", "status": "All"},
  {"id": "0", "status": "Pending"},
  {"id": "1", "status": "Approved"},
  {"id": "2", "status": "Rejected"},
];
