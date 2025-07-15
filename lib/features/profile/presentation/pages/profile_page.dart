import 'package:flutter/material.dart';
import 'package:mobile_store/core/constants/design_constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: kBackgroundColor,
      ),
      body: const Center(
        child: Text('Your Profile!'),
      ),
    );
  }
}
