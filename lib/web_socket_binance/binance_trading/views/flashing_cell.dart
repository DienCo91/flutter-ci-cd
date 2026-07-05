import 'package:flutter/material.dart';

class FlashingCell extends StatefulWidget {
  final String textValue;
  final TextStyle? textStyle;

  const FlashingCell({super.key, required this.textValue, this.textStyle});

  @override
  State<FlashingCell> createState() => _FlashingCellState();
}

class _FlashingCellState extends State<FlashingCell> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  Color _flashColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _colorAnimation = AlwaysStoppedAnimation(Colors.transparent);
  }

  @override
  void didUpdateWidget(covariant FlashingCell oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.textValue != widget.textValue) {
      final oldValue = double.tryParse(oldWidget.textValue) ?? 0.0;
      final newValue = double.tryParse(widget.textValue) ?? 0.0;

      if (newValue > oldValue) {
        _flashColor = Colors.green.withValues(alpha: 0.4);
      } else if (newValue < oldValue) {
        _flashColor = Colors.red.withValues(alpha: 0.4);
      }

      _colorAnimation = ColorTween(begin: _flashColor, end: Colors.transparent).animate(_controller);

      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          color: _colorAnimation.value,
          child: Text(widget.textValue, style: widget.textStyle ?? const TextStyle(fontFamily: 'Monospace')),
        );
      },
    );
  }
}
