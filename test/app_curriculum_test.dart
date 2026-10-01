import 'package:flutter_test/flutter_test.dart';
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

    test('YKS Quest 79 ünite, 553 ders ve 30000+ sorudan oluşur', () {
      expect(mockUnits.length, equals(79));
      final totalLessons = mockUnits.expand((u) => u.lessons).length;
      final totalQuestions = mockUnits.expand((u) => u.lessons).expand((l) => l.questions).length;

      expect(totalLessons, equals(553));
      expect(totalQuestions, greaterThanOrEqualTo(30000));
    });

    test('Her ünitede en az 7 ders bulunur ve her ünitede kupa sınavı yer alır', () {
      for (final unit in mockUnits) {
        expect(unit.lessons.length, greaterThanOrEqualTo(7),
            reason: '${unit.title} en az 7 ders içermeli');
        expect(unit.lessons.any((l) => l.isUnitExam), isTrue,
            reason: '${unit.title} kupa sınavı içermeli');

        for (final lesson in unit.lessons) {
          expect(lesson.questions.length, greaterThanOrEqualTo(50),
              reason: '${lesson.title} dersinde en az 50 soru olmalı');
        }
      }
    });
  });
}
