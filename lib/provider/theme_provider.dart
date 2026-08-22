import 'package:material_ui/material_ui.dart';

class ThemeProvider extends InheritedWidget {
  final Color themeColor;
  final Function(Color) onColorChange;

  const ThemeProvider({
    super.key,
    required this.themeColor,
    required this.onColorChange,
    required super.child,
  });

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeColor != oldWidget.themeColor;
  }
}
