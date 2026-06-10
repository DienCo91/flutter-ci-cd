import 'package:get/state_manager.dart';

class TodoController extends GetxController {
  var textSearch = RxString('');
  var a = ''.obs;
  Rx<String?> x = Rx<String?>('');

  @override
  void onInit() {
    super.onInit();
    debounce(textSearch, (_) {
      search();
    }, time: const Duration(milliseconds: 500));
  }

  void search() {
    print("========= Search with keyword: ${textSearch.value}");
  }
}

