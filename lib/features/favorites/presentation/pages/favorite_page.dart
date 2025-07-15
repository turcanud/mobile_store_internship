import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/core/components/product_grid.dart';
import 'package:mobile_store/core/constants/design_constants.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_state.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.products.isEmpty) {
            return const Center(
                child: Text('Favorites list is empty',
                    style:
                        TextStyle(fontSize: 18, fontFamily: 'SF Pro Display')));
          }
          return ProductGrid(products: state.products, isScrollable: true);
        },
      ),
    );
  }
}
