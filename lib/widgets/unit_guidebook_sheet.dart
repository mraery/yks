import 'package:flutter/material.dart';
import '../models/lesson_models.dart';

class UnitGuidebookSheet extends StatelessWidget {
  final LearningUnit unit;

  const UnitGuidebookSheet({super.key, required this.unit});

  static void show(BuildContext context, LearningUnit unit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => UnitGuidebookSheet(unit: unit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unitColor = Color(unit.colorHex);

    // Ünitedeki tüm conceptCard'ları topla
    final allConceptCards = <MapEntry<String, Question>>[];
    for (final lesson in unit.lessons) {
      for (final q in lesson.questions) {
        if (q.type == QuestionType.conceptCard) {
          allConceptCards.add(MapEntry(lesson.title, q));
        }
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: unitColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.menu_book_rounded, color: unitColor, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ÜNİTE ${unit.unitNumber} CEP REHBERİ',
                        style: TextStyle(
                          color: unitColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        unit.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF4B4B4B),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Color(0xFFAFAFAF), size: 26),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF0F0F0)),

          // Content List
          Expanded(
            child: allConceptCards.isEmpty
                ? const Center(
                    child: Text(
                      'Bu ünite için henüz eklenmiş cep notu bulunmuyor.',
                      style: TextStyle(color: Color(0xFFAFAFAF), fontWeight: FontWeight.w600),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: allConceptCards.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final item = allConceptCards[index];
                      final lessonTitle = item.key;
                      final card = item.value;
                      return _buildGuideCard(context, lessonTitle, card, unitColor);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCard(
    BuildContext context,
    String lessonTitle,
    Question card,
    Color unitColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Etiket (Ders Adı)
          Row(
            children: [
              Text(card.iconEmoji ?? '💡', style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  card.conceptTitle ?? lessonTitle,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF4B4B4B),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  lessonTitle,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF888888),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Kural
          if (card.rule != null && card.rule!.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF2FBF0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF58CC02).withOpacity(0.3)),
              ),
              child: Text(
                card.rule!,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E5A1C),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],

          // Örnekler
          if (card.examples != null && card.examples!.isNotEmpty) ...[
            ...card.examples!.map(
              (ex) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: Color(0xFF1CB0F6), fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        ex,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0369A1),
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],

          // ÖSYM Taktiği
          if (card.examTip != null && card.examTip!.isNotEmpty) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF0),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFFF9600).withOpacity(0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('⚡ ', style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Text(
                      card.examTip!,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFB45309),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
