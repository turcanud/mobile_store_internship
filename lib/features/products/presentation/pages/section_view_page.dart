import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/core/components/product_grid.dart';
import 'package:mobile_store/core/constants/design_constants.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_bloc.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_state.dart';

class SectionViewPage extends StatelessWidget {
  const SectionViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Best Selling'),
        backgroundColor: kBackgroundColor,
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return ProductGrid(products: state.bestSelling, isScrollable: true);
        },
      ),
    );
  }
}
