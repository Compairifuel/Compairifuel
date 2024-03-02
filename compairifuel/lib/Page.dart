import 'package:compairifuel/Content.dart';
import 'package:compairifuel/Header.dart';
import 'package:compairifuel/Navbar.dart';
import 'package:compairifuel/Pagination.dart';
import 'package:flutter/material.dart';

class Page extends StatefulWidget {
  final Header? header;
  final Pagination? pagination;
  final Navbar navbar;
  final String title;
  final Content content;

  const Page({super.key, required this.title, required this.content, required this.navbar, required this.pagination, this.header});

  @override
  State<Page> createState() {
    return _PageState();
  }
}

class _PageState extends State<Page> {
  int pageIndex = 0;

  void changePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: widget.navbar,
      body:Column(
        children: <Widget>[
          if(widget.header != null) widget.header!,
          widget.content as Widget,
          if(widget.pagination != null) widget.pagination!,
        ],
      ),
      );
  }
}