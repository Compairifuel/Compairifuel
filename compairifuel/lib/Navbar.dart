import 'package:compairifuel/NavItem.dart';
import 'package:compairifuel/Page.dart' as PageComponent;
import 'package:compairifuel/Map.dart';
import 'package:compairifuel/Pagination.dart';
import 'package:compairifuel/UserManual.dart';
import 'package:flutter/material.dart';

import 'NavIcon.dart';


class Navbar extends StatefulWidget {
  final List<NavItem> navItemList = [
    NavItem(
        title: "title",
        navIcon: const NavIcon(AssetImage("assets/images/gears.png")),
        navigation: MaterialPageRoute(builder: (context) => PageComponent.Page(title: "title", content: UserManual(), navbar: Navbar(), pagination: const Pagination()))
    ),
    NavItem(
        title: "titllle",
        navIcon: const NavIcon(AssetImage("assets/images/map.png")),
        navigation:  MaterialPageRoute(builder: (context) => PageComponent.Page(title: "titllle", content: Map(), navbar: Navbar(), pagination: const Pagination()))
    ),

  ];

  @override
  State<StatefulWidget> createState() => _Navbar();

  Navbar({super.key});
}
class _Navbar extends State<Navbar> {
  int index = 0;

  @override
  void initState() {
    super.initState();

    // changePage(index);
  }


  void changePage(int i) {
    setState(() {
      index = i;
    });
    Navigator.push(
      context,
      widget.navItemList[i].navigation,
    );
  }
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget.navItemList,
      currentIndex: index,
      onTap: (int index) => changePage(index),
    );
  }
}
