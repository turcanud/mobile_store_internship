import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/features/products/domain/products_repository.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_event.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;

  ProductsBloc(this.repository)
      : super(ProductsState(
            bestSelling: [],
            moreToExplore: [],
            page: 1,
            pageSize: 10,
            allLoaded: false)) {
    on<ProductsLoad>((event, emit) async {
      try {
        if (state.bestSelling.isNotEmpty && state.moreToExplore.isNotEmpty) {
          return;
        }
        final bestSelling = await repository.getBestSelling(queryParams: {
          'page': state.page.toString(),
          'page_size': state.pageSize.toString(),
        });
        final exploreProducts = await repository.getMoreToExplore(queryParams: {
          'page': state.page.toString(),
          'page_size': state.pageSize.toString(),
        });
        emit(ProductsState(
            bestSelling: bestSelling,
            moreToExplore: exploreProducts,
            page: 1,
            pageSize: 10,
            allLoaded: false));
      } catch (e) {
        emit(ProductsState(
            bestSelling: [],
            moreToExplore: [],
            page: 0,
            pageSize: 0,
            allLoaded: false));
      }
    });

    on<ProductsLoadMore>((event, emit) async {
      try {
        int currentPage = state.page + 1;
        final moreProducts = await repository.getMoreToExplore(queryParams: {
          'page': currentPage.toString(),
          'page_size': state.pageSize.toString(),
        });
        if (moreProducts.isEmpty) {
          emit(ProductsState(
              bestSelling: state.bestSelling,
              moreToExplore: state.moreToExplore,
              page: currentPage,
              pageSize: state.pageSize,
              allLoaded: true));
          return;
        }
        emit(ProductsState(
            bestSelling: state.bestSelling,
            moreToExplore: [...state.moreToExplore, ...moreProducts],
            page: currentPage,
            pageSize: state.pageSize,
            allLoaded: false));
      } catch (e) {
        // Handle error
      }
    });
  }
}
