import 'package:flutter/material.dart';
import '../models/lesson_models.dart';

class TrueFalseWidget extends StatelessWidget {
  final Question question;
  final bool? selectedValue;
  final bool isChecked;
  final ValueChanged<bool> onSelect;

  const TrueFalseWidget({
    super.key,
    required this.question,
    required this.selectedValue,
    required this.isChecked,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
            ),
            child: Text(
              question.prompt,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4B4B4B),
                height: 1.4,
              ),
            ),
          ),
          const Spacer(),

          Row(
            children: [
              // DOĞRU
              Expanded(
                child: _buildChoiceCard(
                  value: true,
                  text: 'DOĞRU',
                  icon: Icons.check_circle_rounded,
                  color: const Color(0xFF58CC02),
                  lightBg: const Color(0xFFD7FFB8),
                ),
              ),
              const SizedBox(width: 16),
              // YANLIŞ
              Expanded(
                child: _buildChoiceCard(
                  value: false,
                  text: 'YANLIŞ',
                  icon: Icons.cancel_rounded,
                  color: const Color(0xFFFF4B4B),
                  lightBg: const Color(0xFFFFDFE0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildChoiceCard({
    required bool value,
    required String text,
    required IconData icon,
    required Color color,
    required Color lightBg,
  }) {
    final isSelected = selectedValue == value;
    final isCorrectChoice = isChecked && question.isTrue == value;
    final isWrongChoice = isChecked && isSelected && !isCorrectChoice;

    Color borderColor = const Color(0xFFE5E5E5);
    Color bgColor = Colors.white;
    Color textColor = const Color(0xFF4B4B4B);

    if (isChecked) {
      if (isCorrectChoice) {
        borderColor = const Color(0xFF58CC02);
        bgColor = const Color(0xFFD7FFB8);
        textColor = const Color(0xFF58A700);
      } else if (isWrongChoice) {
        borderColor = const Color(0xFFFF4B4B);
        bgColor = const Color(0xFFFFDFE0);
        textColor = const Color(0xFFEA2B2B);
      }
    } else if (isSelected) {
      borderColor = color;
      bgColor = lightBg;
      textColor = color;
    }

    return InkWell(
      onTap: isChecked ? null : () => onSelect(value),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 3),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.4),
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected || isChecked ? color : const Color(0xFFAFAFAF), size: 40),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
