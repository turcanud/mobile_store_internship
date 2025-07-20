import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/core/components/section_title.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:mobile_store/features/products/domain/product.dart';
import 'package:mobile_store/features/products/presentation/pages/product_page.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
                      child: BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (context, state) {
                          final isFavorite = state.products.contains(product);
                          return IconButton(
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
                                context.read<FavoritesBloc>().add(
                                  FavoritesRemoved(product: product),
                                );
                              } else {
                                context.read<FavoritesBloc>().add(
                                  FavoritesAdded(product: product),
                                );
                              }
                            },
                          );
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
  }
}
