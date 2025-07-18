import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_store/features/categories/domain/category.dart';
import 'package:mobile_store/features/categories/presentation/pages/category_page.dart';

class CategoryItemFeature extends StatelessWidget {
  final Category category;
  const CategoryItemFeature({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(category: category),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Column(
          children: [
            Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(
                      alpha: 50,
                      red: 0,
                      green: 0,
                      blue: 0,
                    ),
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                category.svgPath,
                semanticsLabel: "icon",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 14.0),
            Text(
              category.name,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
