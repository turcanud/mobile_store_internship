import 'package:flutter/material.dart';
import 'package:mobile_store/core/constants/design_constants.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: kBackgroundColor,
      ),
      body: const Center(
        child: Text('Your cart!'),
      ),
    );
  }
}
