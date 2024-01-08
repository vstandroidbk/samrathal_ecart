class ApiEndPoints {
  static const Map<String, dynamic> headerContent = {
    "Content-Type": "application/json",
  };
  static const String envType = "production";
  static const String baseUrl = "https://crm.volansoft.in/"; // development
  // static const String baseUrl = "https://crm.volansoft.in/"; // production

  static const String loginUser = "/login-with-password";
  static const String getDashboardData = "/get-home-userdata";
  static const String getDataManageList = "/batch-list";
  static const String getStatus = "/get-status";
  static const String updateStatus = "/get-status-update";
  static const String createManageData = "/create-by-app";
}
