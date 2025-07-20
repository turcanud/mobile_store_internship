import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_bloc.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_state.dart';
import 'package:mobile_store/features/products/presentation/widgets/product_item.dart';

class ProductsCarousel extends StatelessWidget {
  const ProductsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 316.0,
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          final bestSelling = state.bestSelling;
          if (bestSelling.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: bestSelling.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductItem(product: state.bestSelling[index]);
            },
          );
        },
      ),
    );
  }
}
