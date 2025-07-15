import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/core/components/product_grid.dart';
import 'package:mobile_store/core/components/section_title.dart';
import 'package:mobile_store/core/constants/app_constants.dart';
import 'package:mobile_store/core/widgets/search_bar_and_camera.dart';
import 'package:mobile_store/features/categories/presentation/widgets/categories_carousel.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_bloc.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_event.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_state.dart';
import 'package:mobile_store/features/products/presentation/widgets/products_carousel.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final productsBloc = context.read<ProductsBloc>();
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !productsBloc.state.allLoaded) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      productsBloc.add(ProductsLoadMore());
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.of(context, rootNavigator: true).pop();
      });
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        if (state.bestSelling.isEmpty && state.moreToExplore.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          controller: scrollController,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.layoutDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBarAndCamera(),

                  //Categories section
                  const SectionTitle(title: 'Categories'),

                  const SizedBox(height: 18.0),

                  //A carousel slider for categories
                  const CategoriesCarousel(),

                  //Best Selling Products section
                  Container(
                    margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                    child: Row(
                      children: [
                        const SectionTitle(title: 'Best Selling'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/sectionView');
                          },
                          child: const TitleCustom(
                              title: 'See All',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),

                  //A carousel slider best selling products
                  const ProductsCarousel(),

                  // More Products Section Title
                  Container(
                    margin: const EdgeInsets.only(top: 44.0, bottom: 28.0),
                    child: const SectionTitle(title: 'More to Explore'),
                  ),

                  //A grid view for more products
                  ProductGrid(products: state.moreToExplore),
                  //If all products are loaded, show a message
                  if (state.allLoaded)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: TitleCustom(
                          title: 'All products loaded',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
