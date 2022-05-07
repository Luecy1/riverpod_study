import 'package:flutter_riverpod/flutter_riverpod.dart';

final provider = Provider((ref) {
  return 'HELLO';
});

final futureProvider = FutureProvider(
  (ref) {
    return Future.delayed(const Duration(seconds: 1), () => 'DELAYED ');
  },
);
