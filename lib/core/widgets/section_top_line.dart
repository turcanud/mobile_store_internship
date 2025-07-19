import 'package:flutter/material.dart';
import 'package:mobile_store/core/components/section_title.dart';

class SectionTopLine extends StatelessWidget {
  const SectionTopLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
      child: Row(
        children: [
          const SectionTitle(title: 'Best Selling'),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/sectionView');
            },
            child: const TitleCustom(
              title: 'See All',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
