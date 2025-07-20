import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/features/categories/presentation/bloc/categories_state.dart';
import 'package:mobile_store/features/categories/presentation/widgets/category_item.dart';
import 'package:mobile_store/features/categories/presentation/bloc/categories_bloc.dart';

class CategoriesCarousel extends StatelessWidget {
  const CategoriesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state.categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: state.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryItem(category: state.categories[index]);
            },
          );
        },
      ),
    );
  }
}
