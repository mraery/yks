import '../models/lesson_models.dart';
import '../models/exam_config.dart';
import 'yks_streaming_units.dart';

export 'yks_streaming_units.dart';

/// YKS Quest Resmi Mufredati
final List<LearningUnit> mockUnits = yksStreamingUnits;

List<LearningUnit> getUnitsForExam(ExamFranchise franchise) {
  return yksStreamingUnits;
}
