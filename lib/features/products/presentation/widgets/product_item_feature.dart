import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/core/components/section_title.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:mobile_store/features/products/domain/product.dart';
import 'package:mobile_store/features/products/presentation/pages/product_page.dart';

class ProductItemFeature extends StatelessWidget {
  final Product product;
  const ProductItemFeature({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteBloc = BlocProvider.of<FavoritesBloc>(context, listen: false);
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        // Check if the product is already in favorites
        final isFavorite = state.products.any((p) => p.id == product.id);
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(product: product),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                          width:
                              MediaQuery.of(context).size.width *
                              0.45, // 45% of screen width
                          alignment: Alignment.center,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              isFavorite ? Icons.star : Icons.star_border,
                              color: isFavorite ? Colors.amber : Colors.black,
                            ),
                            color: Colors.white,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder(),
                            ),
                            iconSize: 20,
                            onPressed: () {
                              if (isFavorite) {
                                favoriteBloc.add(
                                  FavoritesRemoved(product: product),
                                );
                              } else {
                                favoriteBloc.add(
                                  FavoritesAdded(product: product),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Product Name
                TitleCustom(
                  title: product.name,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),

                // Product Section/Category
                TitleCustom(
                  title: product.section,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF929292),
                ),

                const SizedBox(height: 4),

                // Price
                TitleCustom(
                  title: '\$${product.price.toStringAsFixed(0)}',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF00C569),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
