import 'package:compairifuel/src/global/ui/widgets/base_screen.dart';
import 'package:compairifuel/src/global/ui/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GasstationDetailScreen extends StatelessWidget {
  const GasstationDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        page: _GasstationDetailPage(
          id: id,
        ),
        navBar: const NavBar());
  }
}

class _GasstationDetailPage extends StatelessWidget {
  const _GasstationDetailPage({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColoredBox(
            color: theme.colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => dismiss(context),
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tankstation Remmerden",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: Colors.black),
                ),
                Text(
                  "1234 Boerenlaan 1b",
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                ),
                Text(
                  "Amsterdam AB",
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                ),
                Text(
                  "Diesel: €1.542",
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                ),
                Text(
                  "Euro95: €1.924",
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void dismiss(BuildContext context) {
    context.pop();
  }
}
