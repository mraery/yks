import 'package:flutter_test/flutter_test.dart';
import 'package:ykslingo/models/exam_config.dart';
import 'package:ykslingo/models/lesson_models.dart';
import 'package:ykslingo/data/mock_lessons.dart';
import 'package:ykslingo/data/dgs_units.dart';
import 'package:ykslingo/data/lgs_units.dart';
import 'package:ykslingo/data/kpss_units.dart';

void main() {
  group('Quest Franchise Ecosystem Tests', () {
    test('All 4 exam franchises are configured with rich metadata', () {
      final exams = [ExamFranchise.yks, ExamFranchise.dgs, ExamFranchise.lgs, ExamFranchise.kpss];
      for (final franchise in exams) {
        final config = ExamConfig.fromFranchise(franchise);
        expect(config.title.contains('Quest'), isTrue);
        expect(config.sections.isNotEmpty, isTrue);
        expect(config.subjects.isNotEmpty, isTrue);
        expect(config.mascotGreeting.isNotEmpty, isTrue);
      }
    });

    test('DGS Quest curriculum has valid units, lessons and question counts (8-12 per lesson)', () {
      expect(dgsUnits.isNotEmpty, isTrue);
      for (final unit in dgsUnits) {
        expect(unit.lessons.isNotEmpty, isTrue);
        final hasTrophy = unit.lessons.any((l) => l.isUnitExam);
        expect(hasTrophy, isTrue, reason: 'Unit ${unit.id} should have a trophy exam');

        for (final lesson in unit.lessons) {
          expect(lesson.questions.length >= 8 && lesson.questions.length <= 12, isTrue,
              reason: 'Lesson ${lesson.id} in ${unit.title} has ${lesson.questions.length} questions');
        }
      }
    });

    test('LGS Quest curriculum has valid units, lessons and question counts (8-12 per lesson)', () {
      expect(lgsUnits.isNotEmpty, isTrue);
      for (final unit in lgsUnits) {
        expect(unit.lessons.isNotEmpty, isTrue);
        final hasTrophy = unit.lessons.any((l) => l.isUnitExam);
        expect(hasTrophy, isTrue, reason: 'Unit ${unit.id} should have a trophy exam');

        for (final lesson in unit.lessons) {
          expect(lesson.questions.length >= 8 && lesson.questions.length <= 12, isTrue,
              reason: 'Lesson ${lesson.id} in ${unit.title} has ${lesson.questions.length} questions');
        }
      }
    });

    test('KPSS Quest curriculum has valid units, lessons and question counts (8-12 per lesson)', () {
      expect(kpssUnits.isNotEmpty, isTrue);
      for (final unit in kpssUnits) {
        expect(unit.lessons.isNotEmpty, isTrue);
        final hasTrophy = unit.lessons.any((l) => l.isUnitExam);
        expect(hasTrophy, isTrue, reason: 'Unit ${unit.id} should have a trophy exam');

        for (final lesson in unit.lessons) {
          expect(lesson.questions.length >= 8 && lesson.questions.length <= 12, isTrue,
              reason: 'Lesson ${lesson.id} in ${unit.title} has ${lesson.questions.length} questions');
        }
      }
    });

    test('getUnitsForExam dynamically switches curriculum for each franchise', () {
      final yks = getUnitsForExam(ExamFranchise.yks);
      final dgs = getUnitsForExam(ExamFranchise.dgs);
      final lgs = getUnitsForExam(ExamFranchise.lgs);
      final kpss = getUnitsForExam(ExamFranchise.kpss);

      expect(yks.length, greaterThanOrEqualTo(79));
      expect(dgs.length, greaterThanOrEqualTo(3));
      expect(lgs.length, greaterThanOrEqualTo(2));
      expect(kpss.length, greaterThanOrEqualTo(2));
    });
  });
}
