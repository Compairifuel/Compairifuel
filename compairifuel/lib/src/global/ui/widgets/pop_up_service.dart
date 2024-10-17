import 'package:compairifuel/src/global/ui/widgets/align_pop_up.dart';
import 'package:flutter/material.dart';

class PopUpService {
  PopUpService({
    this.size,
    required this.context,
    required this.childBuilder,
    this.offset,
    required this.padding,
    required this.buttons,
  }) {
    _callBackMaker(() {
      RenderBox renderBox = (context.findRenderObject()! as RenderBox);
      Size renderBoxSize = renderBox.size;
      Offset renderBoxOffset = renderBox.localToGlobal(Offset.zero);
      size ??= renderBoxSize;
      offset ??= renderBoxOffset;
    });
  }

  PopUpService.absolutePosition(
      {required this.context,
      required this.padding,
      required this.childBuilder,
      required this.buttons,
      required this.offset,
      this.size}) {
    _callBackMaker(() {});
  }

  PopUpService copyWith(
      {Size? size,
      BuildContext? context,
      WidgetBuilder? childBuilder,
      Offset? offset,
      EdgeInsets? padding,
      List<Widget>? buttons}) {
    return PopUpService(
        size: size ?? this.size,
        context: context ?? this.context,
        childBuilder: childBuilder ?? this.childBuilder,
        offset: offset ?? this.offset,
        padding: padding ?? this.padding,
        buttons: buttons ?? this.buttons);
  }

  final BuildContext context;
  Size? size;
  Offset? offset;
  final EdgeInsets padding;
  final WidgetBuilder childBuilder;
  final List<Widget> buttons;

  void _init({
    Size? size,
    required BuildContext context,
    required WidgetBuilder childBuilder,
    Offset? offset,
    required EdgeInsets padding,
    required List<Widget> buttons,
  }) {
    showDialog(
        useRootNavigator: true,
        context: context,
        builder: (context) => AlignPopUp(
            size: size,
            offset: offset,
            padding: padding,
            body: childBuilder,
            buttons: buttons));
  }

  void _callBackMaker(Function callback) {
    if (context.findRenderObject() != null) {
      callback.call();
      _init(
          context: context,
          childBuilder: childBuilder,
          padding: padding,
          buttons: buttons,
          offset: offset,
          size: size);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        callback.call();
        _init(
            context: context,
            childBuilder: childBuilder,
            padding: padding,
            buttons: buttons,
            offset: offset,
            size: size);
      });
    }
  }
}
