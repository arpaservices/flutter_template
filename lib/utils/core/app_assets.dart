/// A utility class for managing asset paths in a structured and efficient way.
///
/// The `AssetsImport` class provides a method to construct file paths for assets
/// in the Flutter project, such as images, by allowing users to pass in a file name and
/// an optional asset type. The default asset type is set to 'images', but this can be
/// customized to suit other asset types like icons, fonts, etc.
class AssetsImport{
  ///
  /// Returns the full asset path for the given file name.
  ///
  /// The [fileName] parameter is the name of the asset file (including the file extension),
  /// for example, `'logo.png'`.
  ///
  /// The optional [assetType] parameter specifies the folder within the `assets` directory
  /// where the asset is located. If not provided, it defaults to `'images'`.
  ///
  /// ### Example:
  /// ```dart
  /// String imagePath = AssetsImport.getAssetPath('logo.png');
  /// // Returns: 'assets/images/logo.png'
  ///
  /// String iconPath = AssetsImport.getAssetPath('icon.svg', assetType: 'icons');
  /// // Returns: 'assets/icons/icon.svg'
  /// ```
  ///
  /// This method is useful for dynamically building asset paths in your Flutter
  /// project, reducing hardcoding of paths and providing flexibility in organizing assets.
  static String getAssetPath(String fileName, {String assetType = 'images'}) {
    return 'assets/$assetType/$fileName';
  }
}