import 'package:git_hooks/git_hooks.dart';
import 'dart:io'; // Bỏ comment dòng này để dùng được ProcessResult và Process

void main(List<String> arguments) {
  // ignore: omit_local_variable_types
  Map<Git, UserBackFun> params = {Git.commitMsg: commitMsg, Git.preCommit: preCommit};
  GitHooks.call(arguments, params);
}

Future<bool> commitMsg() async {
  // Hiện tại trả về true để bạn viết commit message tự do.
  // Nếu sau này muốn bắt team viết đúng chuẩn (ví dụ: feat:, fix:) thì cấu hình ở đây.
  return true;
}

Future<bool> preCommit() async {
  print('==================================================');
  print('🚀 [Git Hook] Đang kiểm tra code trước khi commit...');
  print('==================================================');

  try {
    // 1. Tự động format toàn bộ code trong dự án về một chuẩn duy nhất
    print('🪓 1. Đang tự động format code bằng `dart format`...');
    ProcessResult formatResult = await Process.run('dart', ['format', '.']);
    print(formatResult.stdout);

    // 2. Kiểm tra lỗi linter và compiler bằng `flutter analyze`
    print('🔍 2. Đang phân tích cú pháp bằng `flutter analyze`...');
    ProcessResult analyzeResult = await Process.run('flutter', ['analyze']);

    if (analyzeResult.exitCode != 0) {
      print(analyzeResult.stdout);
      print('❌ [COMMIT THẤT BẠI]: Code của bạn đang bị lỗi compile hoặc lỗi linter.');
      print('💡 Vui lòng sửa hết lỗi hiển thị ở trên rồi thử commit lại nhé!');
      return false; // Chặn không cho commit
    }
  } catch (e) {
    print('💥 Đã xảy ra lỗi khi chạy Git Hook: $e');
    return false; // Chặn commit nếu hook gặp lỗi hệ thống
  }

  print('✅ [SUCCESS]: Code sạch sẽ và đã được format. Tiến hành commit!');
  print('==================================================');
  return true; // Cho phép commit
}
