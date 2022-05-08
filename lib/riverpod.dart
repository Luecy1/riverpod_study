import 'package:flutter_riverpod/flutter_riverpod.dart';

final provider = Provider((ref) {
  return 'HELLO';
});

final futureProvider = FutureProvider((ref) {
  return Future.delayed(const Duration(seconds: 3), () => 'DELAYED ');
});

final streamProvider = StreamProvider((ref) {
  return Stream.periodic(const Duration(seconds: 1), (i) => i);
});

// int型を保持するProvider
final stateProvider = StateProvider((ref) {
  return 0;
});
