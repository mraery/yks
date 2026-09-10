import '../models/lesson_models.dart';
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

/// Tüm TYT ve AYT Branşlarının MEB & ÖSYM Müfredatına Uygun 79 Ünitesi
final List<LearningUnit> mockUnits = [
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
