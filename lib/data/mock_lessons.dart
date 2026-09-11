import '../models/lesson_models.dart';
import '../models/exam_config.dart';
import 'turkce_units.dart';
import 'matematik_units.dart';
import 'fizik_units.dart';
import 'kimya_units.dart';
import 'biyoloji_units.dart';
import 'tarih_units.dart';
import 'cografya_units.dart';
import 'felsefe_units.dart';
import 'din_units.dart';
import 'ayt_matematik_units.dart';
import 'ayt_edebiyat_units.dart';
import 'ayt_fen_units.dart';
import 'dgs_units.dart';
import 'lgs_units.dart';
import 'kpss_units.dart';

export 'turkce_units.dart';
export 'matematik_units.dart';
export 'fizik_units.dart';
export 'kimya_units.dart';
export 'biyoloji_units.dart';
export 'tarih_units.dart';
export 'cografya_units.dart';
export 'felsefe_units.dart';
export 'din_units.dart';
export 'ayt_matematik_units.dart';
export 'ayt_edebiyat_units.dart';
export 'ayt_fen_units.dart';
export 'dgs_units.dart';
export 'lgs_units.dart';
export 'kpss_units.dart';

/// Tüm TYT ve AYT Branşlarının MEB & ÖSYM Müfredatına Uygun 79 Ünitesi
final List<LearningUnit> yksUnits = [
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

/// Geriye dönük uyumluluk için standart liste
final List<LearningUnit> mockUnits = yksUnits;

/// Aktif Quest sınavına göre müfredat ünitelerini döndürür
List<LearningUnit> getUnitsForExam(ExamFranchise franchise) {
  switch (franchise) {
    case ExamFranchise.yks:
      return yksUnits;
    case ExamFranchise.dgs:
      return dgsUnits;
    case ExamFranchise.lgs:
      return lgsUnits;
    case ExamFranchise.kpss:
      return kpssUnits;
  }
}
