import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tutorial_provider.g.dart';

@riverpod
String tutorial(Ref ref) {
  return 'Tutorial';
}
