import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/aution/aution_home.dart';
import 'package:whole_selle_x_application/src/features/home/add_products.dart';
import 'package:whole_selle_x_application/src/features/home/controlller/home_controller.dart';
import 'package:whole_selle_x_application/src/features/home/home_page.dart';
import 'package:whole_selle_x_application/src/features/home/user_profile.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  static final List<Widget> _screens = [
    const HomeScreen(),
    const AddProductsScreen(),
    const UserProfileScreen(),
    const AutionHomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: IndexedStack(
        index: bottomNavProvider.selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorScheme(context).primary,
        fixedColor: colorScheme(context).onPrimary,
        currentIndex: bottomNavProvider.selectedIndex,
        onTap: (index) => bottomNavProvider.setIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange_outlined), label: 'Autions'),
        ],
      ),
    );
  }
}
