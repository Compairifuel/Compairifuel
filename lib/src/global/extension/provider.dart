import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension CacheUntilExtension on Ref {
  void cacheUntil(Duration duration) {
    Timer? existingTimer = read(_cacheUntilTimerProvider);
    if (existingTimer != null && existingTimer.isActive) {
      return;
    }

    final link = keepAlive();

    final Timer timer = Timer(duration, () {
      invalidateSelf();
      link.close();
    });

    Future.microtask(() {
      read(_cacheUntilTimerProvider.notifier).state = timer;
    });

    onCancel(() {
      timer.cancel();
      invalidate(_cacheUntilTimerProvider);
      link.close();
    });
    onDispose(() {
      timer.cancel();
      invalidate(_cacheUntilTimerProvider);
      link.close();
    });
  }
}

final _cacheUntilTimerProvider = StateProvider<Timer?>((ref) => null);
