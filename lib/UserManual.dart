import 'package:compairifuel/Content.dart';
import 'package:flutter/material.dart';

class UserManual extends StatelessWidget implements Content {
  final List<String> textList = ["Contentpage 1","Contentpage 2"];

  UserManual({super.key});

  @override
  Widget build(BuildContext context){
    //TODO
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: ListView.builder(
        itemCount: textList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(textList[index]),
          );
        },
      ),
    );
  }
}