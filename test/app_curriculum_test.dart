import 'package:flutter_test/flutter_test.dart';
import 'package:kpss_quest/models/lesson_models.dart';
import 'package:kpss_quest/models/exam_config.dart';
import 'package:kpss_quest/data/mock_lessons.dart';

void main() {
  group('KPSS Quest ÖSYM Sınav Sistemi ve Müfredat Testleri', () {
    test('ÖSYM KPSS Genel Yetenek & Genel Kültür net hesaplama kuralı (4Y = -1D)', () {
      final config = ExamConfig.fromFranchise(ExamFranchise.kpss);
      expect(config.officialBody, equals('ÖSYM'));
      expect(config.penaltyRatio, equals(4));
      expect(config.penaltyRuleText.contains('4 Yanlış 1 Doğru'), isTrue);

      // Net formülü doğrulaması
      expect(config.calculateNet(15, 4), equals(14.0));
      expect(config.calculateNet(10, 6), equals(8.5));
      expect(config.calculateNet(1, 4), equals(0.0));
    });

    test('KPSS Quest 27 ünite, 54 ders ve 430+ sorudan oluşur', () {
      expect(mockUnits.length, equals(27));
      final totalLessons = mockUnits.expand((u) => u.lessons).length;
      final totalQuestions = mockUnits.expand((u) => u.lessons).expand((l) => l.questions).length;

      expect(totalLessons, equals(54));
      expect(totalQuestions, greaterThanOrEqualTo(430));
    });

    test('Her derste 8-12 soru bulunur, ilk soru kavram kartıdır ve son ders kupa sınavıdır', () {
      for (final unit in mockUnits) {
        expect(unit.lessons.length, equals(2));
        expect(unit.lessons.last.isUnitExam, isTrue, reason: '${unit.title} son dersi kupa sınavı olmalı');

        for (final lesson in unit.lessons) {
          expect(lesson.questions.length >= 8 && lesson.questions.length <= 12, isTrue,
              reason: '${lesson.title} dersinde ${lesson.questions.length} soru var');
          expect(lesson.questions.first.type, equals(QuestionType.conceptCard),
              reason: '${lesson.title} ilk adımı kavram kartı olmalı');
        }
      }
    });

    test('KPSS branş dağılımı GY ve GK müfredatını kapsar', () {
      final subjects = mockUnits.map((u) => u.subject).toSet();
      expect(subjects.contains('KPSS Tarih'), isTrue);
      expect(subjects.contains('KPSS Coğrafya'), isTrue);
      expect(subjects.any((s) => s.contains('Vatandaşlık')), isTrue);
      expect(subjects.contains('KPSS Güncel Bilgiler'), isTrue);
      expect(subjects.contains('KPSS Türkçe & Mantık'), isTrue);
      expect(subjects.contains('KPSS Matematik'), isTrue);
    });
  });
}
