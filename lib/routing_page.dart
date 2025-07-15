import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_store/core/constants/design_constants.dart';
import 'package:mobile_store/features/cart/presentation/pages/cart_page.dart';
import 'package:mobile_store/main_page.dart';
import 'package:mobile_store/features/profile/presentation/pages/profile_page.dart';

class RoutingPage extends StatefulWidget {
  const RoutingPage({super.key});

  @override
  State<RoutingPage> createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = [MainPage(), CartPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Text(
              "Explore",
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w700,
              ),
            ),
            label: "•",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/products/bottom_nav_icons/cart.svg',
              semanticsLabel: 'Cart icon',
              width: 32.0,
              height: 32.0,
            ),
            label: '•',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/products/bottom_nav_icons/user.svg',
              semanticsLabel: 'Profile icon',
              width: 32.0,
              height: 32.0,
            ),
            label: '•',
          ),
        ],
      ),
    );
  }
}
