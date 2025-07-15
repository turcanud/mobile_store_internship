import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/features/categories/presentation/widgets/category_item_feature.dart';
import 'package:mobile_store/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:mobile_store/features/categories/presentation/bloc/categories_state.dart';

class CategoriesCarousel extends StatelessWidget {
  const CategoriesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return SizedBox(
          height: 100.0,
          child: ListView.builder(
            itemCount: state.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryItemFeature(category: state.categories[index]);
            },
          ),
        );
      },
    );
  }
}
