import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson_models.dart';

class CurriculumRemoteService {
  static const String _githubRawBase =
      'https://raw.githubusercontent.com/mraery';

  /// Sınav müfredat kataloğunu (iskelet üniteleri) yükler
  static Future<List<LearningUnit>> loadCurriculumCatalog({
    required String repoName,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheKey = 'catalog_${repoName}_v1';
      final cachedJson = prefs.getString(cacheKey);

      List<dynamic> jsonList;
      if (cachedJson != null && cachedJson.isNotEmpty) {
        jsonList = jsonDecode(cachedJson) as List<dynamic>;
      } else {
        // Yerel asset'ten yükle
        final assetString =
            await rootBundle.loadString('assets/curriculum/index.json');
        jsonList = jsonDecode(assetString) as List<dynamic>;
        // Ön belleğe kaydet
        await prefs.setString(cacheKey, assetString);
      }

      final units = jsonList.map((item) {
        final map = item as Map<String, dynamic>;
        final lessons = (map['lessons'] as List<dynamic>?)
                ?.map((l) => Lesson.fromJson(l as Map<String, dynamic>))
                .toList() ??
            [];
        return LearningUnit(
          id: map['id']?.toString() ?? '',
          unitNumber: map['unitNumber'] as int? ?? 1,
          title: map['title']?.toString() ?? '',
          subject: map['subject']?.toString() ?? '',
          colorHex: map['colorHex'] as int? ?? 0xFF4F46E5,
          lessons: lessons,
          isDownloaded: false,
        );
      }).toList();

      return units;
    } catch (e) {
      debugPrint('Katalog yükleme hatası ($repoName): $e');
      return [];
    }
  }

  /// Ünitenin cihazda önbelleğe alınıp alınmadığını kontrol eder
  static Future<bool> isUnitDownloaded(
      String repoName, String unitId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey('unit_json_${repoName}_$unitId');
    } catch (_) {
      return false;
    }
  }

  /// Belirli bir ünitenin soru ve ders içeriklerini internetten çeker ve önbelleğe yazar
  static Future<LearningUnit> loadUnitContent({
    required String repoName,
    required LearningUnit skeleton,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'unit_json_${repoName}_${skeleton.id}';

    // 1. Önbellekte var mı kontrol et
    final cached = prefs.getString(cacheKey);
    if (cached != null && cached.isNotEmpty) {
      try {
        final decoded = jsonDecode(cached) as Map<String, dynamic>;
        return LearningUnit.fromJson(decoded, isDownloaded: true);
      } catch (e) {
        debugPrint('Önbellek okuma hatası (${skeleton.id}): $e');
      }
    }

    // 2. Yerel assette var mı kontrol et (Örnek başlangıç ünitesi)
    try {
      final assetPath = 'assets/curriculum/${skeleton.id}.json';
      final assetString = await rootBundle.loadString(assetPath);
      final decoded = jsonDecode(assetString) as Map<String, dynamic>;
      final unit = LearningUnit.fromJson(decoded, isDownloaded: true);
      await prefs.setString(cacheKey, assetString);
      return unit;
    } catch (_) {
      // Assette yoksa remote'dan çekmeye devam et
    }

    // 3. GitHub Raw / CDN üzerinden dinamik olarak indir
    final remoteUrl =
        '$_githubRawBase/$repoName/main/curriculum/${skeleton.id}.json';
    HttpClient? client;
    try {
      client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 12);
      final request = await client.getUrl(Uri.parse(remoteUrl));
      request.headers.set('User-Agent', 'QuestApp/$repoName');
      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody =
            await response.transform(utf8.decoder).join();
        final decoded =
            jsonDecode(responseBody) as Map<String, dynamic>;
        final loadedUnit =
            LearningUnit.fromJson(decoded, isDownloaded: true);

        // Gelecek kullanımlar için yerel cihaza kaydet
        await prefs.setString(cacheKey, responseBody);
        return loadedUnit;
      } else {
        throw HttpException(
            'İndirme başarısız (HTTP ${response.statusCode})');
      }
    } catch (e) {
      debugPrint('Remote indirme hatası ($remoteUrl): $e');
      // Son çare: Eğer starter_unit.json varsa ve bu 1. ünite ise onu yükle
      if (skeleton.unitNumber == 1) {
        try {
          final starterStr =
              await rootBundle.loadString('assets/curriculum/starter_unit.json');
          final decoded = jsonDecode(starterStr) as Map<String, dynamic>;
          return LearningUnit.fromJson(decoded, isDownloaded: true);
        } catch (_) {}
      }
      rethrow;
    } finally {
      client?.close();
    }
  }

  /// Kullanıcının tüm üniteleri tek tıkla indirmesini sağlar
  static Future<int> downloadAllUnits({
    required String repoName,
    required List<LearningUnit> units,
    Function(int completed, int total)? onProgress,
  }) async {
    int count = 0;
    for (int i = 0; i < units.length; i++) {
      try {
        await loadUnitContent(repoName: repoName, skeleton: units[i]);
        count++;
        onProgress?.call(count, units.length);
      } catch (e) {
        debugPrint('Toplu indirmede ünite atlandı: ${units[i].id} - $e');
      }
    }
    return count;
  }
}
