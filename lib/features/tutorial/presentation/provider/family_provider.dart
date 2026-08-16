import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_provider.g.dart';

@riverpod
class FamilyNotifier extends _$FamilyNotifier {
  @override
  Future<String> build(String id) async {
    return id;
  }

  Future<void> updateId(String id) async {
    state = AsyncValue.loading();
    state = AsyncValue.data(id);
  }
}
