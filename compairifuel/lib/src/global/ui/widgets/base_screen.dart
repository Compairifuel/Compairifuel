import "package:flutter/material.dart";

class BaseScreen extends StatelessWidget {
  const BaseScreen(
      {super.key, required this.page, required this.navBar, this.header});

  final Widget navBar;
  final Widget? header;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);
    ThemeData theme = Theme.of(context);
    TargetPlatform targetPlatform = theme.platform;

    return (targetPlatform == TargetPlatform.iOS ||
            targetPlatform == TargetPlatform.android ||
            screenSize.width <= 700)
        ? Scaffold(
            body: SafeArea(
                child: Column(
                    children: [
              header,
              Expanded(child: page),
              SafeArea(child: navBar)
            ].nonNulls.toList())),
          )
        : Scaffold(
            body: Row(
              children: [
                SafeArea(
                  child: navBar,
                ),
                Expanded(
                    child: SafeArea(
                        child: Column(
                            children: [header, Expanded(child: page)]
                                .nonNulls
                                .toList())))
              ],
            ),
          );
  }
}
