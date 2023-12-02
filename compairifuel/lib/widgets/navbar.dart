import 'package:flutter/material.dart';
import '../pages/usermanual.dart';
//
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();

}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.map),
                label: 'Map',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
        )
    );
  }
}
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }
//
// class _NavItem extends StatelessWidget {
//   final IconData icon;
//   bool isSelected;
//
//   _NavItem({required this.icon, required this.isSelected});
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }