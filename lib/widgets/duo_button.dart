import 'package:flutter/material.dart';

enum DuoButtonColor {
  green,
  blue,
  red,
  gray,
  white,
  purple,
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

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;

    // Modern YKS Renk Paleti ve Degradeler
    LinearGradient? gradient;
    Color solidColor;
    Color textColor;
    Color glowColor;

    if (!isEnabled) {
      solidColor = const Color(0xFFE2E8F0);
      textColor = const Color(0xFF94A3B8);
      glowColor = Colors.transparent;
    } else {
      switch (widget.color) {
        case DuoButtonColor.green:
          gradient = const LinearGradient(
            colors: [Color(0xFF059669), Color(0xFF10B981)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
          solidColor = const Color(0xFF10B981);
          textColor = Colors.white;
          glowColor = const Color(0xFF10B981).withOpacity(0.35);
        case DuoButtonColor.blue:
          gradient = const LinearGradient(
            colors: [Color(0xFF0284C7), Color(0xFF38BDF8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
          solidColor = const Color(0xFF0284C7);
          textColor = Colors.white;
          glowColor = const Color(0xFF0284C7).withOpacity(0.35);
        case DuoButtonColor.red:
          gradient = const LinearGradient(
            colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
          solidColor = const Color(0xFFEF4444);
          textColor = Colors.white;
          glowColor = const Color(0xFFEF4444).withOpacity(0.35);
        case DuoButtonColor.purple:
          gradient = const LinearGradient(
            colors: [Color(0xFF6D28D9), Color(0xFF8B5CF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
          solidColor = const Color(0xFF7C3AED);
          textColor = Colors.white;
          glowColor = const Color(0xFF7C3AED).withOpacity(0.35);
        case DuoButtonColor.white:
          solidColor = Colors.white;
          textColor = const Color(0xFF1E293B);
          glowColor = Colors.black.withOpacity(0.04);
        case DuoButtonColor.gray:
          solidColor = const Color(0xFFF1F5F9);
          textColor = const Color(0xFF334155);
          glowColor = Colors.transparent;
      }
    }

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled
          ? (_) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            color: solidColor,
            gradient: gradient,
            borderRadius: BorderRadius.circular(18),
            border: widget.color == DuoButtonColor.white
                ? Border.all(color: const Color(0xFFE2E8F0), width: 1.5)
                : (widget.color == DuoButtonColor.gray
                    ? Border.all(color: const Color(0xFFCBD5E1), width: 1.5)
                    : null),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: glowColor,
                      blurRadius: _isPressed ? 4 : 12,
                      offset: Offset(0, _isPressed ? 2 : 4),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
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
                  fontSize: 15.5,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef YksButton = DuoButton;
typedef YksButtonColor = DuoButtonColor;
