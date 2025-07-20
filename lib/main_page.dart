import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/core/components/product_grid.dart';
import 'package:mobile_store/core/components/section_title.dart';
import 'package:mobile_store/core/constants/app_constants.dart';
import 'package:mobile_store/core/widgets/search_bar_and_camera.dart';
import 'package:mobile_store/core/widgets/section_top_line.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final productsBloc = context.read<ProductsBloc>();
    if (_scrollController.position.atEdge &&
        _scrollController.position.pixels != 0 &&
        !productsBloc.state.allLoaded) {
      _onEndReached(productsBloc);
    }
  }

  void _onEndReached(ProductsBloc productsBloc) {
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

  @override
  Widget build(BuildContext context) {
    List<Widget> buildCategories = [
      const SearchBarAndCamera(),
      const SectionTitle(title: 'Categories'),
      const SizedBox(height: 18.0),
      const CategoriesCarousel(),
      const SectionTopLine(),
      const ProductsCarousel(),
      Container(
        margin: const EdgeInsets.only(top: 44.0, bottom: 28.0),
        child: const SectionTitle(title: 'More to Explore'),
      ),
      BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state.bestSelling.isEmpty && state.moreToExplore.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ProductGrid(products: state.moreToExplore);
        },
      ),
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.layoutDefaultPadding,
        ),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: buildCategories.length,
          itemBuilder: (context, index) {
            return buildCategories[index];
          },
        ),
      ),
    );
  }
}
