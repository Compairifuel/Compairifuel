import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension CacheForExtension on Ref {
  void cacheFor(Duration duration) {
    Timer timer = Timer(duration, () {
      invalidateSelf();
    });
    onCancel(() {
      timer.cancel();
    });
    onDispose(() {
      timer.cancel();
    });
    onResume(() {
      timer.cancel();
    });
  }
}
