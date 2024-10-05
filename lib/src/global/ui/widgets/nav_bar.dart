import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:compairifuel/src/global/extension/localization.dart';
import 'package:compairifuel/src/global/ui/widgets/nav_item.dart';
import 'package:compairifuel/src/routers.dart';

class NavBar extends StatelessWidget {
  final List<NavItem>? items;

  const NavBar({super.key, this.items});

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations();

    var navItems = items ??
        [
          NavItem(
              icon: const Icon(Icons.book),
              name: localization.usermanualTitle,
              location: () => context.go(AppRoute.manual.path)),
          NavItem(
              icon: const Icon(Icons.map),
              name: "Map",
              location: () => context.go(AppRoute.map.path))
        ];

    MediaQueryData mediaQuery = MediaQuery.of(context);
    Size screenSize = mediaQuery.size;
    ThemeData theme = Theme.of(context);
    TargetPlatform targetPlatform = theme.platform;

    var direction = (targetPlatform == TargetPlatform.iOS ||
            targetPlatform == TargetPlatform.android ||
            screenSize.width <= 700)
        ? Axis.horizontal
        : Axis.vertical;

    return Flex(
        mainAxisAlignment: direction == Axis.horizontal
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.start,
        direction: direction,
        children: [...navItems]);
  }
}
