import 'package:flutter/material.dart';
import 'package:compairifuel/src/global/extension/localization.dart';
import 'package:compairifuel/src/global/ui/widgets/base_screen.dart';
import 'package:compairifuel/src/global/ui/widgets/header.dart';
import 'package:compairifuel/src/global/ui/widgets/nav_bar.dart';
import 'package:compairifuel/src/global/ui/widgets/header_title.dart';

class UserManualScreen extends StatelessWidget {
  const UserManualScreen({super.key, required this.onMap});

  final Function() onMap;

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations();

    return BaseScreen(
        navBar: const NavBar(),
        header: Header(title: HeaderTitle(text: localization.usermanualTitle)),
        page: _UserManualPage());
  }
}

class _UserManualPage extends StatefulWidget {
  @override
  State<_UserManualPage> createState() => _UserManualPageState();
}

class _UserManualPageState extends State<_UserManualPage> {
  var pageController = PageController();
  var textList = [
    "This is a usermanuel. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    "This is a usermanuel pagina 2. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TargetPlatform targetPlatform = theme.platform;

    return Container(
      color: theme.colorScheme.primary,
      child: PageView(
        controller: pageController,
        children: textList.map((e) {
          return (targetPlatform == TargetPlatform.android ||
                  targetPlatform == TargetPlatform.iOS)
              ? Text(
                  e,
                  softWrap: true,
                )
              : SelectableText(
                  e,
                  showCursor: true,
                );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
