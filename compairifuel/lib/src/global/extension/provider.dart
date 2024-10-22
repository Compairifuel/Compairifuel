import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension CacheForExtension on Ref {
  void cacheFor(Duration duration) {
    Timer? existingTimer = read(_cacheForTimerProvider);
    if (existingTimer != null && existingTimer.isActive) {
      print("A timer already exists for this provider. ${toString()}");
      return;
    }

    final link = keepAlive();

    final Timer timer = Timer(duration, () {
      print("Timer expired for this provider. ${toString()}");
      invalidateSelf();
      link.close();
    });

    Future.microtask(() {
      print("Timer created for this provider. ${toString()}");
      read(_cacheForTimerProvider.notifier).state = timer;
    });

    onCancel(() {
      print("Canceling timer for this provider. ${toString()}");
      timer.cancel();
      invalidate(_cacheForTimerProvider);
      link.close();
    });
    onDispose(() {
      print("Disposing timer for this provider. ${toString()}");
      timer.cancel();
      invalidate(_cacheForTimerProvider);
      link.close();
    });
  }
}

final _cacheForTimerProvider = StateProvider<Timer?>((ref) => null);
