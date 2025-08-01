import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/core/components/product_grid.dart';
import 'package:mobile_store/core/constants/design_constants.dart';
import 'package:mobile_store/features/categories/domain/category.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_bloc.dart';

class CategoryPage extends StatelessWidget {
  final Category category;
  const CategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final filteredProducts = [
      ...context.read<ProductsBloc>().state.bestSelling,
      ...context.read<ProductsBloc>().state.moreToExplore,
    ].where((product) => product.categoryId == category.id).toList();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: kBackgroundColor,
      ),
      body: filteredProducts.isEmpty
          ? const Center(
              child: Text(
                'No products available in this category',
                style: TextStyle(fontSize: 18, fontFamily: 'SF Pro Display'),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: ProductGrid(
                products: filteredProducts,
                isScrollable: true,
              ),
            ),
    );
  }
}
