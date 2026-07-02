import 'dart:io';
import 'dart:math';
import 'dart:convert';

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('Error: --sides is required.');
    stderr.writeln('Usage: dart scripts/check.dart --sides 20');
    exit(1);
  }

  final parsed = int.tryParse(args[1]);
  if (parsed == null || parsed < 2) {
    stderr.writeln('Error: sides must be a number >= 2');
    exit(1);
  }

  final result = Random().nextInt(parsed) + 1;

  print(jsonEncode({"sides": parsed, "result": result}));
}
