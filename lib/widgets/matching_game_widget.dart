import 'package:flutter/material.dart';
import '../models/lesson_models.dart';

class MatchingGameWidget extends StatefulWidget {
  final Question question;
  final Map<String, String> matchedPairs;
  final String? selectedLeft;
  final String? selectedRight;
  final String? mismatchedLeft;
  final String? mismatchedRight;
  final bool isChecked;
  final ValueChanged<String> onSelectLeft;
  final ValueChanged<String> onSelectRight;

  const MatchingGameWidget({
    super.key,
    required this.question,
    required this.matchedPairs,
    required this.selectedLeft,
    required this.selectedRight,
    this.mismatchedLeft,
    this.mismatchedRight,
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

  bool _isMatched(String text, bool isLeft) {
    if (isLeft) {
      return widget.matchedPairs.containsKey(text);
    } else {
      return widget.matchedPairs.containsValue(text);
    }
  }

  bool _isMismatched(String text, bool isLeft) {
    if (isLeft) {
      return widget.mismatchedLeft == text;
    } else {
      return widget.mismatchedRight == text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPairs = widget.question.matchingPairs?.length ?? 0;
    final matchedCount = widget.matchedPairs.length;
    final isAllMatched = totalPairs > 0 && matchedCount == totalPairs;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.question.prompt,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Kartları eşleştir. Doğruysa yeşil olur, yanlışsa kırmızı yanıp reddedilir.',
                  style: TextStyle(fontSize: 12.5, color: Color(0xFF64748B), height: 1.25),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isAllMatched ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isAllMatched ? const Color(0xFF10B981) : const Color(0xFFCBD5E1),
                  ),
                ),
                child: Text(
                  isAllMatched ? '🎉 Tamamlandı' : '$matchedCount / $totalPairs Eşleşti',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: isAllMatched ? const Color(0xFF15803D) : const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sol Kartlar
              Expanded(
                child: Column(
                  children: _shuffledLeft.map((leftText) {
                    final isMatched = _isMatched(leftText, true);
                    final isMismatched = _isMismatched(leftText, true);
                    final isSelected = widget.selectedLeft == leftText;

                    return _buildCard(
                      text: leftText,
                      isSelected: isSelected,
                      isMatched: isMatched,
                      isMismatched: isMismatched,
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
                    final isMatched = _isMatched(rightText, false);
                    final isMismatched = _isMismatched(rightText, false);
                    final isSelected = widget.selectedRight == rightText;

                    return _buildCard(
                      text: rightText,
                      isSelected: isSelected,
                      isMatched: isMatched,
                      isMismatched: isMismatched,
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
    required bool isMatched,
    required bool isMismatched,
    required VoidCallback onTap,
  }) {
    Color borderColor = const Color(0xFFE2E8F0);
    Color bgColor = Colors.white;
    Color textColor = const Color(0xFF1E293B);
    Color? badgeColor;
    String? badgeText;

    if (isMismatched) {
      // ❌ YANLIŞ: Kırmızı yanar ve reddedilir
      borderColor = const Color(0xFFEF4444);
      bgColor = const Color(0xFFFEE2E2);
      textColor = const Color(0xFFB91C1C);
      badgeColor = const Color(0xFFEF4444);
      badgeText = '✗';
    } else if (isMatched) {
      // ✅ DOĞRU: Yeşil olur ve kilitlenir
      borderColor = const Color(0xFF10B981);
      bgColor = const Color(0xFFDCFCE7);
      textColor = const Color(0xFF15803D);
      badgeColor = const Color(0xFF10B981);
      badgeText = '✓';
    } else if (isSelected) {
      // 🔵 SEÇİLİ: Mavi/İndigo parlar
      borderColor = const Color(0xFF3B82F6);
      bgColor = const Color(0xFFEFF6FF);
      textColor = const Color(0xFF1D4ED8);
    }

    final isClickable = !isMatched && !isMismatched && !widget.isChecked;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: isClickable ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          constraints: const BoxConstraints(minHeight: 68),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: isMatched || isMismatched || isSelected ? 2.4 : 1.8,
            ),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.28),
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
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: badgeColor!.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
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
