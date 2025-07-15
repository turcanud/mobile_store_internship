import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_bloc.dart';
import 'package:mobile_store/features/products/presentation/widgets/product_item_feature.dart';

class ProductsCarousel extends StatelessWidget {
  const ProductsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final productsBloc = context.read<ProductsBloc>();
    final bestSelling = productsBloc.state.bestSelling;
    return SizedBox(
      height: 316.0,
      child: ListView.builder(
        itemCount: bestSelling.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductItemFeature(product: bestSelling[index]);
        },
      ),
    );
  }
}
