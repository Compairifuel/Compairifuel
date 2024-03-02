
import 'package:compairifuel/NavIcon.dart';
import 'package:flutter/material.dart';

class NavItem extends BottomNavigationBarItem {
  final String title;
  final NavIcon navIcon;
  final MaterialPageRoute navigation;

  NavItem({required this.title, required this.navIcon, required this.navigation}) : super(icon: navIcon, label: title);
}