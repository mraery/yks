import 'dart:convert';
import 'dart:io';
import '../lib/models/lesson_models.dart';
import '../lib/data/turkce_units.dart';
import '../lib/data/matematik_units.dart';
import '../lib/data/fizik_units.dart';
import '../lib/data/kimya_units.dart';
import '../lib/data/biyoloji_units.dart';
import '../lib/data/tarih_units.dart';
import '../lib/data/cografya_units.dart';
import '../lib/data/felsefe_units.dart';
import '../lib/data/din_units.dart';
import '../lib/data/ayt_matematik_units.dart';
import '../lib/data/ayt_edebiyat_units.dart';
import '../lib/data/ayt_fen_units.dart';

void main() {
  final dir = Directory('curriculum');
  if (!dir.existsSync()) dir.createSync(recursive: true);

  final List<LearningUnit> allYksUnits = [
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

  for (final unit in allYksUnits) {
    final file = File('curriculum/${unit.id}.json');
    file.writeAsStringSync(jsonEncode(unit.toJson()));
  }
  print('Exported ${allYksUnits.length} YKS units to curriculum/*.json');
}
