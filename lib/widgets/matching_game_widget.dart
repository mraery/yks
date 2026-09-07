import 'package:flutter/material.dart';
import '../models/lesson_models.dart';

class MatchingGameWidget extends StatefulWidget {
  final Question question;
  final Map<String, String> matchedPairs;
  final String? selectedLeft;
  final String? selectedRight;
  final bool isChecked;
  final ValueChanged<String> onSelectLeft;
  final ValueChanged<String> onSelectRight;

  const MatchingGameWidget({
    super.key,
    required this.question,
    required this.matchedPairs,
    required this.selectedLeft,
    required this.selectedRight,
    this.isChecked = false,
    required this.onSelectLeft,
    required this.onSelectRight,
  });

  @override
  State<MatchingGameWidget> createState() => _MatchingGameWidgetState();
}

class _MatchingGameWidgetState extends State<MatchingGameWidget> {
  late List<String> _shuffledLeft;
  late List<String> _shuffledRight;

  // Çiftler için 4 farklı belirgin renk
  static const List<Color> _pairColors = [
    Color(0xFF1CB0F6), // Mavi
    Color(0xFF8B5CF6), // Mor
    Color(0xFFFF9600), // Turuncu
    Color(0xFF00B4D8), // Turkuaz
  ];

  static const List<Color> _pairBgColors = [
    Color(0xFFE0F2FE),
    Color(0xFFEDE9FE),
    Color(0xFFFEF3C7),
    Color(0xFFE0F7FA),
  ];

  @override
  void initState() {
    super.initState();
    _initCards();
  }

  @override
  void didUpdateWidget(covariant MatchingGameWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.id != widget.question.id) {
      _initCards();
    }
  }

  void _initCards() {
    final pairs = widget.question.matchingPairs ?? [];
    _shuffledLeft = pairs.map((p) => p.left).toList()..shuffle();
    _shuffledRight = pairs.map((p) => p.right).toList()..shuffle();
  }

  int? _getPairNumber(String text, bool isLeft) {
    int index = 0;
    for (final entry in widget.matchedPairs.entries) {
      if ((isLeft && entry.key == text) || (!isLeft && entry.value == text)) {
        return index + 1;
      }
      index++;
    }
    return null;
  }

  bool _isPairCorrect(String text, bool isLeft) {
    final pairs = widget.question.matchingPairs ?? [];
    if (isLeft) {
      final right = widget.matchedPairs[text];
      return pairs.any((p) => p.left == text && p.right == right);
    } else {
      String? matchedLeft;
      for (final entry in widget.matchedPairs.entries) {
        if (entry.value == text) {
          matchedLeft = entry.key;
          break;
        }
      }
      if (matchedLeft == null) return false;
      return pairs.any((p) => p.left == matchedLeft && p.right == text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPairs = widget.question.matchingPairs?.length ?? 0;
    final matchedCount = widget.matchedPairs.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.question.prompt,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4B4B4B),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                'Eşleştirmek için iki taraftan birer karta dokunun.',
                style: const TextStyle(fontSize: 13, color: Color(0xFFAFAFAF)),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E5E5)),
                ),
                child: Text(
                  '$matchedCount / $totalPairs Eşleşti',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: matchedCount == totalPairs ? const Color(0xFF58CC02) : const Color(0xFF777777),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sol Kartlar
              Expanded(
                child: Column(
                  children: _shuffledLeft.map((leftText) {
                    final pairNumber = _getPairNumber(leftText, true);
                    final isSelected = widget.selectedLeft == leftText;
                    final isCorrect = widget.isChecked && pairNumber != null
                        ? _isPairCorrect(leftText, true)
                        : null;

                    return _buildCard(
                      text: leftText,
                      isSelected: isSelected,
                      pairNumber: pairNumber,
                      isCorrect: isCorrect,
                      onTap: () => widget.onSelectLeft(leftText),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 14),
              // Sağ Kartlar
              Expanded(
                child: Column(
                  children: _shuffledRight.map((rightText) {
                    final pairNumber = _getPairNumber(rightText, false);
                    final isSelected = widget.selectedRight == rightText;
                    final isCorrect = widget.isChecked && pairNumber != null
                        ? _isPairCorrect(rightText, false)
                        : null;

                    return _buildCard(
                      text: rightText,
                      isSelected: isSelected,
                      pairNumber: pairNumber,
                      isCorrect: isCorrect,
                      onTap: () => widget.onSelectRight(rightText),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String text,
    required bool isSelected,
    required int? pairNumber,
    required bool? isCorrect,
    required VoidCallback onTap,
  }) {
    Color borderColor = const Color(0xFFE5E5E5);
    Color bgColor = Colors.white;
    Color textColor = const Color(0xFF4B4B4B);
    Color? badgeColor;
    String? badgeText;

    if (widget.isChecked && pairNumber != null) {
      if (isCorrect == true) {
        borderColor = const Color(0xFF58CC02);
        bgColor = const Color(0xFFD7FFB8);
        textColor = const Color(0xFF58A700);
        badgeColor = const Color(0xFF58CC02);
        badgeText = '✓';
      } else {
        borderColor = const Color(0xFFFF4B4B);
        bgColor = const Color(0xFFFFDFE0);
        textColor = const Color(0xFFEA2B2B);
        badgeColor = const Color(0xFFFF4B4B);
        badgeText = '✗';
      }
    } else if (pairNumber != null) {
      final colorIdx = (pairNumber - 1) % _pairColors.length;
      borderColor = _pairColors[colorIdx];
      bgColor = _pairBgColors[colorIdx];
      textColor = _pairColors[colorIdx];
      badgeColor = _pairColors[colorIdx];
      badgeText = '#$pairNumber';
    } else if (isSelected) {
      borderColor = const Color(0xFF84D8FF);
      bgColor = const Color(0xFFDDF4FF);
      textColor = const Color(0xFF1899D6);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: widget.isChecked ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          constraints: const BoxConstraints(minHeight: 68),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: pairNumber != null || isSelected ? 2.5 : 2),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.35),
                offset: const Offset(0, 3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              if (badgeText != null)
                Positioned(
                  top: -8,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
