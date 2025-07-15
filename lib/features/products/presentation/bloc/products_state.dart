import 'package:mobile_store/features/products/domain/product.dart';

class ProductsState {
  final List<Product> bestSelling;
  final List<Product> moreToExplore;
  final int page;
  final int pageSize;
  final bool allLoaded;
  final String? error;

  ProductsState({
    required this.bestSelling,
    required this.moreToExplore,
    required this.page,
    required this.pageSize,
    required this.allLoaded,
    this.error,
  });
}
