import '../models/lesson_models.dart';
import '../models/exam_config.dart';
import 'kpss_units.dart';

export 'kpss_units.dart';

/// KPSS Quest Resmi ÖSYM GY & GK Müfredatı
final List<LearningUnit> mockUnits = kpssUnits;

/// Aktif Quest sınavına göre müfredat ünitelerini döndürür
List<LearningUnit> getUnitsForExam(ExamFranchise franchise) {
  return kpssUnits;
}
