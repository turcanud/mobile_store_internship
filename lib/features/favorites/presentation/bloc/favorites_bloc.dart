import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState(products: [])) {
    on<FavoritesAdded>((event, emit) {
      emit(FavoritesState(products: [...state.products, event.product]));
    });
    on<FavoritesRemoved>((event, emit) {
      emit(FavoritesState(
          products: state.products.where((p) => p != event.product).toList()));
    });
  }
}
