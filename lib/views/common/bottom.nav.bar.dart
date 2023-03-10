import 'package:flutter/material.dart';
import 'package:movie_app/provider/app.provider.dart';
import 'package:movie_app/views/common/bottom.nav.bar.item.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (_, provider, __) {
      return Container(
        width: double.infinity,
        color: Colors.white,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavBarItem(
              icon: Icons.home,
              name: 'Home',
              isSelected: provider.selectedIndex == 0,
              onTap: () {
                provider.updatedSelectedIndex(0);
              },
            ),
            BottomNavBarItem(
              icon: Icons.search,
              name: 'Search',
              isSelected: provider.selectedIndex == 1,
              onTap: () {
                provider.updatedSelectedIndex(1);
              },
            ),
            BottomNavBarItem(
              icon: Icons.favorite,
              name: 'Activity',
              isSelected: provider.selectedIndex == 2,
              onTap: () {
                provider.updatedSelectedIndex(2);
              },
            ),
            BottomNavBarItem(
              icon: Icons.person,
              name: 'Profile',
              isSelected: provider.selectedIndex == 3,
              onTap: () {
                provider.updatedSelectedIndex(3);
              },
            ),
          ],
        ),
      );
    });
  }
}
