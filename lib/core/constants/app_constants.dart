class AppConstants {
  // App basic info
  static const String appName = '';
  static const String appVersion = '1.0.0';
  static const String appLegalese = '© 2025 All rights reserved.';

  // Default Values
  static const double layoutDefaultPadding = 16.0;

  // API Configuration
  static const String baseUrl = 'http://10.0.2.2:3000/api';
  static const String bestSellingProductsEndpoint =
      '/products/best-sold-products';
  static const String moreToExploreEndpoint = '/products/more-to-explore';
  static const String categoriesEndpoint = '/categories';

  // Local Storage Keys
  static const String userDataKey = 'user_data';
  static const String cartKey = 'local_cart';
  static const String favoriteKey = 'local_favorite';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';
}
