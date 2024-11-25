import 'package:compairifuel/src/global/ui/widgets/base_screen.dart';
import 'package:compairifuel/src/global/ui/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:compairifuel/src/global/providers/fuel_option_provider.dart';
import 'package:compairifuel/src/global/providers/fuel_price_provider.dart';
import 'package:compairifuel/src/global/providers/gasstations_provider.dart';

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

class _GasstationDetailPage extends ConsumerWidget {
  const _GasstationDetailPage({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final gasstation =
        ref.watch(gasStationNotifierProvider.notifier).getGasStationById(id);

    final fuelOption = ref.watch(fuelOptionProvider).name;
    final gasstationDetails = ref.watch(fuelPriceProvider(id));

    final priceText = gasstationDetails.when(
      data: (data) => Text(
        "$fuelOption: €${data.price.toStringAsFixed(3)}",
        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
      ),
      error: (err, __) => Text(
        "$fuelOption: -",
        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
      ),
      loading: () => const CircularProgressIndicator(),
    );

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
            child: gasstation != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        gasstation.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        gasstation.address,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                        softWrap: true,
                      ),
                      priceText,
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
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
