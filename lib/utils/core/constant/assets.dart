class Assets {
  static String getPNGImage(String imageName) => 'assets/images/png/$imageName';
  static String getSVGImage(String imageName) => 'assets/images/svg/$imageName';
  static String getAppServices() => 'assets/app_setting/app_services.json';
  static String getAppSettings(String assetName) =>
      'assets/app_setting/$assetName';
}
