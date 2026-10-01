import 'package:flutter_riverpod/legacy.dart';
import '../models/exam_config.dart';
import '../models/lesson_models.dart';
import '../data/mock_lessons.dart';
import '../services/curriculum_remote_service.dart';

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

class UnitsNotifier extends StateNotifier<List<LearningUnit>> {
  final ExamFranchise franchise;

  UnitsNotifier(this.franchise) : super(getUnitsForExam(franchise)) {
    loadCachedUnits();
  }

  Future<void> loadCachedUnits() async {
    final List<LearningUnit> updated = [];
    bool hasChange = false;
    for (final unit in state) {
      if (unit.isLoaded) {
        updated.add(unit);
      } else {
        try {
          final cached = await CurriculumRemoteService.loadUnitContent(
            repoName: franchise.name,
            skeleton: unit,
          );
          if (cached.isLoaded) {
            updated.add(cached);
            hasChange = true;
          } else {
            updated.add(unit);
          }
        } catch (_) {
          updated.add(unit);
        }
      }
    }
    if (hasChange) {
      state = updated;
    }
  }

  void updateUnit(LearningUnit loadedUnit) {
    state = [
      for (final u in state)
        if (u.id == loadedUnit.id) loadedUnit else u
    ];
  }
}

final currentUnitsProvider = StateNotifierProvider<UnitsNotifier, List<LearningUnit>>((ref) {
  final config = ref.watch(examConfigProvider);
  return UnitsNotifier(config.franchise);
});
