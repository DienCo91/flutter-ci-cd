import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<Color> {
  ThemeCubit({Color? color}) : super(color ?? const Color(0xFF673AB7));

  void changeColor(Color color) {
    emit(color);
  }
}
