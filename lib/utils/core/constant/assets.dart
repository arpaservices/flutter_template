class AssetsImport{
  static String getAssetPath(String fileName, {String assetType = 'images'}) {
    return 'assets/$assetType/$fileName';
  }
}