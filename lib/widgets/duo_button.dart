import 'package:flutter/material.dart';

enum DuoButtonColor {
  green,
  blue,
  red,
  gray,
  white,
}

class DuoButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final DuoButtonColor color;
  final double height;
  final double? width;
  final IconData? icon;

  const DuoButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = DuoButtonColor.green,
    this.height = 50,
    this.width,
    this.icon,
  });

  @override
  State<DuoButton> createState() => _DuoButtonState();
}

class _DuoButtonState extends State<DuoButton> {
  bool _isPressed = false;

  (Color surface, Color shadow, Color textColor) _getColors() {
    if (widget.onPressed == null) {
      return (
        const Color(0xFFE5E5E5),
        const Color(0xFFCECECE),
        const Color(0xFFAFAFAF)
      );
    }
    switch (widget.color) {
      case DuoButtonColor.green:
        return (
          const Color(0xFF58CC02),
          const Color(0xFF46A302),
          Colors.white,
        );
      case DuoButtonColor.blue:
        return (
          const Color(0xFF1CB0F6),
          const Color(0xFF1899D6),
          Colors.white,
        );
      case DuoButtonColor.red:
        return (
          const Color(0xFFFF4B4B),
          const Color(0xFFD32F2F),
          Colors.white,
        );
      case DuoButtonColor.white:
        return (
          Colors.white,
          const Color(0xFFE5E5E5),
          const Color(0xFF4B4B4B),
        );
      case DuoButtonColor.gray:
        return (
          const Color(0xFFF7F7F7),
          const Color(0xFFE5E5E5),
          const Color(0xFF4B4B4B),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final (surfaceColor, shadowColor, textColor) = _getColors();
    const shadowDepth = 4.0;

    return GestureDetector(
      onTapDown: widget.onPressed == null
          ? null
          : (_) => setState(() => _isPressed = true),
      onTapUp: widget.onPressed == null
          ? null
          : (_) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
            },
      onTapCancel: () => setState(() => _isPressed = false),
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height,
        child: Stack(
          children: [
            // Shadow / Base Layer
            Positioned(
              top: shadowDepth,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: shadowColor,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            // Top Pushable Surface
            AnimatedPositioned(
              duration: const Duration(milliseconds: 60),
              top: _isPressed ? shadowDepth : 0,
              bottom: _isPressed ? 0 : shadowDepth,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: widget.color == DuoButtonColor.white ||
                          widget.color == DuoButtonColor.gray
                      ? Border.all(color: const Color(0xFFE5E5E5), width: 2)
                      : null,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: textColor, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text.toUpperCase(),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
