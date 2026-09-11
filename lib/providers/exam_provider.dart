import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/exam_config.dart';
import '../models/lesson_models.dart';
import '../data/mock_lessons.dart';

const String _compileTimeExam = String.fromEnvironment('EXAM', defaultValue: 'yks');

class ExamNotifier extends StateNotifier<ExamConfig> {
  ExamNotifier([ExamFranchise franchise = ExamFranchise.yks])
      : super(ExamConfig.fromFranchise(franchise));

  void selectExam(ExamFranchise franchise) {
    state = ExamConfig.fromFranchise(franchise);
  }
}

final examConfigProvider = StateNotifierProvider<ExamNotifier, ExamConfig>((ref) {
  return ExamNotifier(ExamConfig.fromString(_compileTimeExam));
});

final currentUnitsProvider = Provider<List<LearningUnit>>((ref) {
  final config = ref.watch(examConfigProvider);
  return getUnitsForExam(config.franchise);
});
