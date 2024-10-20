import 'package:compairifuel/src/global/ui/widgets/align_pop_up.dart';
import 'package:flutter/material.dart';

class PopUpService {
  PopUpService({
    required this.context,
    required this.padding,
    required this.childBuilder,
    required this.buttons,
    this.offset,
    this.size,
  }) {
    _callbackInitializer(() {
      RenderBox renderBox = (context.findRenderObject()! as RenderBox);
      Offset renderBoxOffset = renderBox.localToGlobal(Offset.zero);
      Size renderBoxSize = renderBox.size;
      offset ??= renderBoxOffset;
      size ??= renderBoxSize;
    });
  }

  PopUpService.absolutePosition(
      {required this.context,
      required this.padding,
      required this.childBuilder,
      required this.buttons,
      required this.offset,
      this.size}) {
    _callbackInitializer();
  }

  final BuildContext context;
  final EdgeInsets padding;
  final WidgetBuilder childBuilder;
  final List<Widget> buttons;
  Offset? offset;
  Size? size;

  void _init({
    required BuildContext context,
    required EdgeInsets padding,
    required WidgetBuilder childBuilder,
    required List<Widget> buttons,
    Offset? offset,
    Size? size,
  }) {
    showDialog(
      useRootNavigator: true,
      context: context,
      builder: (context) => AlignPopUp(
        padding: padding,
        body: childBuilder,
        buttons: buttons,
        offset: offset,
        size: size,
      ),
    );
  }

  void _callbackInitializer([VoidCallback? callback]) {
    if (context.findRenderObject() == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _callbackInitializer(callback);
      });
    } else {
      callback?.call();
      _init(
        context: context,
        padding: padding,
        childBuilder: childBuilder,
        buttons: buttons,
        offset: offset,
        size: size,
      );
    }
  }
}
