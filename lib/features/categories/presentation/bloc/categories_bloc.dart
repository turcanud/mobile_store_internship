import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/features/categories/presentation/bloc/categories_event.dart';
import 'package:mobile_store/features/categories/presentation/bloc/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState(categories: [])) {
    on<CategoriesLoad>((event, emit) async {
      try {
        // Check cache first
        if (state.categories.isNotEmpty) {
          return; // Already have data
        }
        final categories = await event.getCategories();
        emit(CategoriesState(categories: categories));
      } catch (e) {
        // Handle error - you might want to show cached data here if available
        emit(CategoriesState(categories: []));
      }
    });
  }
}
