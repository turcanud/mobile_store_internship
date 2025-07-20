import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_store/core/components/section_title.dart';
import 'package:mobile_store/features/products/domain/product.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_bloc.dart';
import 'package:mobile_store/features/products/presentation/pages/product_page.dart';

class SearchBarAndCamera extends StatelessWidget {
  const SearchBarAndCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 44.0),
      child: Row(
        children: [
          Expanded(
            child: SearchAnchor.bar(
              barSide: const WidgetStatePropertyAll(BorderSide.none),
              barBackgroundColor: const WidgetStatePropertyAll(
                Color(0xFFF7F7F7),
              ),
              barElevation: const WidgetStatePropertyAll(0),
              barShape: const WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(45.0)),
                ),
              ),
              viewBackgroundColor: Colors.white,
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                    final String input = controller.value.text;
                    final products = [
                      ...context.read<ProductsBloc>().state.moreToExplore,
                      ...context.read<ProductsBloc>().state.bestSelling,
                    ];
                    return products
                        .where(
                          (item) => item.name.toLowerCase().contains(
                            input.toLowerCase(),
                          ),
                        )
                        .map(
                          (filteredProduct) => ItemTile(
                            product: filteredProduct,
                            onTap: () {
                              controller.closeView(filteredProduct.name);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductPage(product: filteredProduct),
                                ),
                              );
                            },
                          ),
                        );
                  },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 13.0),
            child: SizedBox(
              height: 40.0,
              width: 40.0,
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/camera.svg',
                  semanticsLabel: 'Camera icon',
                ),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF00C569),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/favorites');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ItemTile({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TitleCustom(
        title: product.name,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      subtitle: TitleCustom(
        title: '\$${product.price.toStringAsFixed(0)}',
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF00C569),
      ),
      onTap: onTap,
    );
  }
}
