import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:mobile_store/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:mobile_store/features/categories/presentation/bloc/categories_event.dart';
import 'package:mobile_store/features/favorites/presentation/pages/favorite_page.dart';
import 'package:mobile_store/features/products/domain/products_repository.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_bloc.dart';
import 'package:mobile_store/features/products/presentation/bloc/products_event.dart';
import 'package:mobile_store/features/products/presentation/pages/section_view_page.dart';
import 'package:mobile_store/routing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesBloc>(
          create: (context) => CategoriesBloc()..add(CategoriesLoad()),
        ),
        BlocProvider<ProductsBloc>(
          create: (context) =>
              ProductsBloc(ProductsRepository())..add(ProductsLoad()),
        ),
        BlocProvider<FavoritesBloc>(create: (context) => FavoritesBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const RoutingPage(),
        routes: {
          '/sectionView': (context) => const SectionViewPage(),
          '/favorites': (context) => const FavoritePage(),
        },
      ),
    );
  }
}
