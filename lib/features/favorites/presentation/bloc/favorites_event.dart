import 'package:mobile_store/features/products/domain/product.dart';

abstract class FavoritesEvent {}

class FavoritesAdded extends FavoritesEvent {
  final Product product;
  FavoritesAdded({required this.product});
}

class FavoritesRemoved extends FavoritesEvent {
  final Product product;
  FavoritesRemoved({required this.product});
}
