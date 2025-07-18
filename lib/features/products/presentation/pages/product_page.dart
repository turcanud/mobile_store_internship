import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/core/components/section_title.dart';
import 'package:mobile_store/core/constants/design_constants.dart';
import 'package:mobile_store/features/products/domain/product.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_state.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key, required this.product});
  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'gray':
        return Colors.grey;
      case 'brown':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final initialImageHeight = screenHeight * 0.5; // Half screen height

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: initialImageHeight,
            floating: false,
            pinned: false,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  bool isFavorite = state.products.any(
                    (fav) => fav.id == product.id,
                  );
                  return Container(
                    margin: const EdgeInsets.only(right: 16.0, top: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: isFavorite ? Colors.amber : Colors.black,
                      ),
                      onPressed: () {
                        final favoriteBloc = context.read<FavoritesBloc>();
                        if (isFavorite) {
                          favoriteBloc.add(FavoritesRemoved(product: product));
                        } else {
                          favoriteBloc.add(FavoritesAdded(product: product));
                        }
                      },
                    ),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: initialImageHeight,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 100),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleCustom(
                    title: product.name,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 16),

                  // Size and Color Selectors Row
                  Row(
                    children: [
                      // Size Selector
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleCustom(
                              title: 'Size',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: .7,
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: product.sizes?.isNotEmpty == true
                                    ? product.sizes!.first
                                    : null,
                                isExpanded: true,
                                underline: const SizedBox(),
                                hint: const Text('Select size'),
                                dropdownColor: Colors.white,
                                items:
                                    product.sizes?.map((String size) {
                                      return DropdownMenuItem<String>(
                                        value: size,
                                        child: Text(size),
                                      );
                                    }).toList() ??
                                    [],
                                onChanged: (String? newValue) {
                                  // TODO: Implement size selection logic if needed.
                                  // Currently not implemented as this is a stateless widget.
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Color Selector
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleCustom(
                              title: 'Color',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: .7,
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: product.colours?.isNotEmpty == true
                                    ? product.colours!.first
                                    : null,
                                isExpanded: true,
                                underline: const SizedBox(),
                                hint: const Text('Select colour'),
                                dropdownColor: Colors.white,
                                items:
                                    product.colours?.map((String colour) {
                                      return DropdownMenuItem<String>(
                                        value: colour,
                                        //background color
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                color: _getColorFromName(
                                                  colour,
                                                ),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.grey[300]!,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(colour),
                                          ],
                                        ),
                                      );
                                    }).toList() ??
                                    [],
                                onChanged: (String? newValue) {
                                  // Handle color selection
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const TitleCustom(
                    title: 'Details',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 6.0),
                  // Read More Section
                  const TitleCustom(
                    title: 'Read More',
                    color: Color(0xFF00C569),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 24),

                  // Reviews Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TitleCustom(
                        title: 'Reviews',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle write review
                        },
                        child: const TitleCustom(
                          title: 'Write yours',
                          color: Color(0xFF00C569),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Reviews List
                  if (product.reviews != null && product.reviews!.isNotEmpty)
                    ...product.reviews!.map(
                      (review) => Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey[600],
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        review.author,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: List.generate(5, (index) {
                                          return Icon(
                                            index < review.rating
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: Colors.amber,
                                            size: 16,
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              review.content,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.4,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'No reviews yet. Be the first to review this product!',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 84,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleCustom(
                    title: 'PRICE',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF929292),
                  ),
                  TitleCustom(
                    title: '\$${product.price.toStringAsFixed(0)}',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF00C569),
                  ),
                ],
              ),
              SizedBox(
                width: 146,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle add to cart functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart!'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C569),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const TitleCustom(
                    title: 'ADD',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
