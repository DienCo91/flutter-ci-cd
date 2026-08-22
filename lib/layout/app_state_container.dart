import 'package:batterylevel/provider/theme_provider.dart';
import 'package:material_ui/material_ui.dart';

class AppStateContainer extends StatefulWidget {
  final Widget child;
  const AppStateContainer({super.key, required this.child});

  @override
  State<AppStateContainer> createState() => _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  Color _currentColor = Colors.deepPurple;

  void changeToBlue(Color color) {
    setState(() {
      _currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeColor: _currentColor,
      onColorChange: changeToBlue,
      child: widget.child,
    );
  }
}
