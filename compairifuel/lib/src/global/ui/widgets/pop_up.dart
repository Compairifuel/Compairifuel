import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  final EdgeInsets padding;
  final WidgetBuilder body;
  final List<Widget> buttons;
  final Size size;
  final Color color;

  const PopUp(
      {super.key,
      required this.padding,
      required this.body,
      required this.buttons,
      required this.size,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          content: SizedBox(
            width: size.width,
            child: Padding(
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  body.call(context),
                  Padding(
                    padding: EdgeInsets.only(
                      top: buttons.isNotEmpty ? 40 : 0,
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: buttons,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
