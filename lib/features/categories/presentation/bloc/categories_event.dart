import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_store/features/categories/domain/category.dart';
import 'package:mobile_store/core/constants/app_constants.dart';

abstract class CategoriesEvent {}

class CategoriesLoad extends CategoriesEvent {
  Future<List<Category>> getCategories() async {
    final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.categoriesEndpoint}'));

    if (response.statusCode == 200) {
      final categoryJson = jsonDecode(response.body);
      return List<Category>.from(
          categoryJson.map((category) => Category.fromJson(category)));
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
