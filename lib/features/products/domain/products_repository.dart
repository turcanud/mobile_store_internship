import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_store/core/constants/app_constants.dart';
import 'package:mobile_store/features/products/domain/product.dart';

class ProductsRepository {
  Future<List<Product>> getBestSelling(
      {Map<String, String>? queryParams}) async {
    final uri = Uri.parse(
            '${AppConstants.baseUrl}${AppConstants.bestSellingProductsEndpoint}')
        .replace(queryParameters: queryParams);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final productJson = jsonDecode(response.body);
      return List<Product>.from(
          productJson.map((product) => Product.fromJson(product)));
    } else {
      throw Exception(
          'Failed to load best selling products. Status code: ${response.statusCode}, Body: ${response.body}');
    }
  }

  Future<List<Product>> getMoreToExplore(
      {Map<String, String>? queryParams}) async {
    final uri = Uri.parse(
            '${AppConstants.baseUrl}${AppConstants.moreToExploreEndpoint}')
        .replace(queryParameters: queryParams);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final productJson = jsonDecode(response.body);
      return List<Product>.from(
          productJson.map((product) => Product.fromJson(product)));
    } else {
      throw Exception(
          'Failed to load more products. Status code: ${response.statusCode}, Body: ${response.body}');
    }
  }
}
