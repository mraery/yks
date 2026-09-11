import 'package:flutter/material.dart';
import '../models/lesson_models.dart';

class FillInBlankWidget extends StatelessWidget {
  final Question question;
  final String? selectedAnswer;
  final bool isChecked;
  final ValueChanged<String?> onSelect;

  const FillInBlankWidget({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.isChecked,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final options = question.blankOptions ?? [];
    final prompt = question.prompt;
    final isCorrect = isChecked && selectedAnswer == question.correctBlankAnswer;
    final isWrong = isChecked && selectedAnswer != question.correctBlankAnswer;

    // Cümleyi "_____" veya "[...]" sembolüne göre böl
    final parts = _splitSentence(prompt);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Üst Yönerge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F6FD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.edit_note_rounded, color: Color(0xFF1CB0F6), size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Boşluğu doğru kelimeyle doldur:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF4B4B4B),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Cümle & Boşluk Kartı
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              runSpacing: 10,
              children: [
                if (parts.isNotEmpty)
                  Text(
                    parts[0],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4B4B4B),
                      height: 1.5,
                    ),
                  ),

                // Boşluk Yuvası (Doldurulan Alan)
                _buildBlankSlot(context, isCorrect, isWrong),

                if (parts.length > 1)
                  Text(
                    parts[1],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4B4B4B),
                      height: 1.5,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 36),

          // Kelime Bankası Başlığı
          const Text(
            'KELİME HAVUZU',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: Color(0xFFAFAFAF),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),

          // Kelime Butonları (Duolingo 3D Chips)
          Wrap(
            spacing: 10,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: options.map((word) {
              final isUsed = selectedAnswer == word;
              return _buildWordChip(word, isUsed);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBlankSlot(BuildContext context, bool isCorrect, bool isWrong) {
    if (selectedAnswer == null) {
      // Boş durum
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFBDBDBD),
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        child: const Text(
          '   ?   ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Color(0xFFAFAFAF),
          ),
        ),
      );
    }

    // Kelime yerleştirilmiş durum
    Color slotColor = const Color(0xFF1CB0F6);
    Color slotBg = const Color(0xFFE5F6FD);
    if (isChecked) {
      slotColor = isCorrect ? const Color(0xFF58CC02) : const Color(0xFFFF4B4B);
      slotBg = isCorrect ? const Color(0xFFD7FFB8) : const Color(0xFFFFDFE0);
    }

    return InkWell(
      onTap: isChecked ? null : () => onSelect(null),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: slotBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: slotColor, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedAnswer!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: slotColor,
              ),
            ),
            if (!isChecked) ...[
              const SizedBox(width: 6),
              Icon(Icons.close_rounded, size: 16, color: slotColor),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildWordChip(String word, bool isUsed) {
    if (isUsed) {
      // Zaten kullanılmış kelime gri/boş kutu olarak görünür
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E5E5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          word,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.transparent,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: isChecked ? null : () => onSelect(word),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFCECECE),
              offset: Offset(0, 3),
              blurRadius: 0,
            ),
          ],
        ),
        child: Text(
          word,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Color(0xFF4B4B4B),
          ),
        ),
      ),
    );
  }

  List<String> _splitSentence(String text) {
    if (text.contains('_____')) {
      return text.split('_____');
    }
    if (text.contains('___')) {
      return text.split('___');
    }
    if (text.contains('[...]')) {
      return text.split('[...]');
    }
    return [text];
  }
}
