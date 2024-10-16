import 'package:compairifuel/src/global/ui/widgets/pop_up.dart';
import 'package:flutter/material.dart';

class AlignPopUp extends StatelessWidget {
  const AlignPopUp(
      {super.key,
      required this.padding,
      required this.body,
      required this.buttons,
      this.offset,
      this.size});

  final EdgeInsets padding;
  final WidgetBuilder body;
  final List<Widget> buttons;
  final Size? size;
  final Offset? offset;

  @override
  Widget build(BuildContext context) {
    Size popUpSize = size ?? MediaQuery.sizeOf(context);
    Offset popUpOffset = offset ?? Offset.zero;

    var bottomPadding =
        MediaQuery.sizeOf(context).bottomCenter(popUpOffset).dy -
            popUpSize.height;
    var topPadding = popUpOffset.dy;
    var leftPadding = popUpOffset.dx;
    var rightPadding =
        popUpOffset.dx + popUpSize.width - (popUpSize.topRight(popUpOffset).dx);

    var positioning = EdgeInsets.fromLTRB(
        leftPadding, topPadding, rightPadding, bottomPadding);
    return Padding(
      padding: positioning,
      child: PopUp(
        padding: padding,
        body: body,
        buttons: buttons,
        size: popUpSize,
      ),
    );
  }
}
