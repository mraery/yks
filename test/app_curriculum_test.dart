import 'package:flutter_test/flutter_test.dart';
import 'package:ykslingo/models/lesson_models.dart';
import 'package:ykslingo/models/exam_config.dart';
import 'package:ykslingo/data/mock_lessons.dart';

void main() {
  group('YKS Quest ÖSYM Sınav Sistemi ve Müfredat Testleri', () {
    test('ÖSYM YKS (TYT & AYT) resmi net hesaplama kuralı (4Y = -1D)', () {
      final config = ExamConfig.fromFranchise(ExamFranchise.yks);
      expect(config.officialBody, equals('ÖSYM'));
      expect(config.penaltyRatio, equals(4));
      expect(config.penaltyRuleText.contains('4 Yanlış 1 Doğru'), isTrue);

      expect(config.calculateNet(15, 4), equals(14.0));
      expect(config.calculateNet(10, 6), equals(8.5));
    });

    test('YKS Quest 79 ünite, 320 ders ve 3000+ sorudan oluşur', () {
      expect(mockUnits.length, equals(79));
      final totalLessons = mockUnits.expand((u) => u.lessons).length;
      final totalQuestions = mockUnits.expand((u) => u.lessons).expand((l) => l.questions).length;

      expect(totalLessons, equals(320));
      expect(totalQuestions, greaterThanOrEqualTo(3000));
    });

    test('Her derste 8-12 soru bulunur ve her ünitede kupa sınavı yer alır', () {
      for (final unit in mockUnits) {
        expect(unit.lessons.any((l) => l.isUnitExam), isTrue, reason: '${unit.title} kupa sınavı içermeli');

        for (final lesson in unit.lessons) {
          expect(lesson.questions.length >= 8 && lesson.questions.length <= 12, isTrue,
              reason: '${lesson.title} dersinde ${lesson.questions.length} soru var');
        }
      }
    });
  });
}
