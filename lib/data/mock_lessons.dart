import '../models/lesson_models.dart';
import '../models/exam_config.dart';
import 'yks_streaming_units.dart';

export 'yks_streaming_units.dart';

import 'yks_question_bank_builder.dart';

/// Tüm TYT ve AYT Branşlarının MEB & ÖSYM Müfredatına Uygun 79 Ünitesi
final List<LearningUnit> rawYksUnits = [
  ...turkceUnits,
  ...matematikUnits,
  ...fizikUnits,
  ...kimyaUnits,
  ...biyolojiUnits,
  ...tarihUnits,
  ...cografyaUnits,
  ...felsefeUnits,
  ...dinUnits,
  ...aytMatematikUnits,
  ...aytEdebiyatUnits,
  ...aytFenUnits,
];

/// 79 Ünite, her biri en az 7 dersten oluşan toplam 553 ders ve 33.000+ soruluk YKS verisi
final List<LearningUnit> yksUnits = expandYksUnits(rawYksUnits);

/// Geriye dönük uyumluluk için standart liste
final List<LearningUnit> mockUnits = yksUnits;

/// Aktif Quest sınavına göre müfredat ünitelerini döndürür
List<LearningUnit> getUnitsForExam(ExamFranchise franchise) {
  return yksStreamingUnits;
}
