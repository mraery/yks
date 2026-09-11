import 'package:flutter/material.dart';
import '../models/lesson_models.dart';
import 'biology_diagram_widget.dart';

class MultipleChoiceWidget extends StatelessWidget {
  final Question question;
  final int? selectedIndex;
  final bool isChecked;
  final ValueChanged<int> onSelect;

  const MultipleChoiceWidget({
    super.key,
    required this.question,
    required this.selectedIndex,
    required this.isChecked,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final options = question.options ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Paragraf veya Metin (varsa)
          if (question.passage != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
              ),
              child: Text(
                question.passage!,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF4B4B4B),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],

          // Biyoloji / Şema Görseli (varsa)
          if (question.diagramType != null) ...[
            BiologyDiagramWidget(diagramType: question.diagramType!),
          ],

          // Soru Metni
          Text(
            question.prompt,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4B4B4B),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          // Seçenekler
          ...List.generate(options.length, (index) {
            final isSelected = selectedIndex == index;
            final isCorrectAnswer = isChecked && index == question.correctIndex;
            final isWrongSelected = isChecked && isSelected && !isCorrectAnswer;

            Color borderColor = const Color(0xFFE5E5E5);
            Color bgColor = Colors.white;
            Color textColor = const Color(0xFF4B4B4B);

            if (isChecked) {
              if (isCorrectAnswer) {
                borderColor = const Color(0xFF58CC02);
                bgColor = const Color(0xFFD7FFB8);
                textColor = const Color(0xFF58A700);
              } else if (isWrongSelected) {
                borderColor = const Color(0xFFFF4B4B);
                bgColor = const Color(0xFFFFDFE0);
                textColor = const Color(0xFFEA2B2B);
              }
            } else if (isSelected) {
              borderColor = const Color(0xFF84D8FF);
              bgColor = const Color(0xFFDDF4FF);
              textColor = const Color(0xFF1899D6);
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: isChecked ? null : () => onSelect(index),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: borderColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: borderColor.withOpacity(0.35),
                        offset: const Offset(0, 3.5),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Belirgin A, B, C, D Şık Rozeti
                      Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected || isCorrectAnswer ? borderColor : const Color(0xFFE5E5E5),
                            width: 2,
                          ),
                          color: isSelected || isCorrectAnswer
                              ? borderColor
                              : const Color(0xFFF7F7F7),
                        ),
                        child: Text(
                          String.fromCharCode(65 + index), // A, B, C, D
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: isSelected || isCorrectAnswer
                                ? Colors.white
                                : const Color(0xFF777777),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          options[index],
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: textColor,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
