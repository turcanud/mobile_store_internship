import 'package:flutter/material.dart';
import 'package:mobile_store/features/products/presentation/widgets/product_item_feature.dart';
import 'package:mobile_store/features/products/domain/product.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final bool isScrollable;
  const ProductGrid({
    super.key,
    required this.products,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: products.length,
      shrinkWrap: true,
      physics: isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ProductItemFeature(product: products[index]);
      },
    );
  }
}
