import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/exam_config.dart';
import '../models/lesson_models.dart';
import '../data/mock_lessons.dart';

const String _compileTimeExam = String.fromEnvironment('EXAM', defaultValue: 'yks');

class ExamNotifier extends StateNotifier<ExamConfig> {
  static const String _prefsKey = 'selected_exam_franchise_key';

  ExamNotifier() : super(ExamConfig.fromFranchise(ExamConfig.fromString(_compileTimeExam))) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedStr = prefs.getString(_prefsKey);
      if (savedStr != null && savedStr.isNotEmpty) {
        state = ExamConfig.fromFranchise(ExamConfig.fromString(savedStr));
      }
    } catch (_) {
      // Ignore in tests or fallback
    }
  }

  Future<void> selectExam(ExamFranchise franchise) async {
    state = ExamConfig.fromFranchise(franchise);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, franchise.name);
    } catch (_) {
      // Ignore
    }
  }
}

final examConfigProvider = StateNotifierProvider<ExamNotifier, ExamConfig>((ref) {
  return ExamNotifier();
});

final currentUnitsProvider = Provider<List<LearningUnit>>((ref) {
  final config = ref.watch(examConfigProvider);
  return getUnitsForExam(config.franchise);
});
