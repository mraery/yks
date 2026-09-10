import 'dart:convert';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson_models.dart';

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  return UserProfileNotifier();
});

class UserProfileNotifier extends StateNotifier<UserProfile> {
  UserProfileNotifier() : super(const UserProfile()) {
    _loadFromPrefs();
  }

  static const String _keyHearts = 'user_hearts';
  static const String _keyStreak = 'user_streak';
  static const String _keyXp = 'user_xp';
  static const String _keyGems = 'user_gems';
  static const String _keyCompletedLessons = 'user_completed_lessons';
  static const String _keyLessonScores = 'user_lesson_scores';
  static const String _keyLastDate = 'user_last_date';
  static const String _keyCheatUnlocked = 'user_cheat_unlocked';
  static const String _keyPremium = 'user_is_premium';
  static const String _keyQuestionsAnswered = 'user_questions_answered';

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    final hearts = prefs.getInt(_keyHearts) ?? 5;
    final streak = prefs.getInt(_keyStreak) ?? 0;
    final xp = prefs.getInt(_keyXp) ?? 0;
    final gems = prefs.getInt(_keyGems) ?? 100;
    final completed = prefs.getStringList(_keyCompletedLessons)?.toSet() ?? {};
    final lastDate = prefs.getString(_keyLastDate) ?? '';
    final isCheatUnlocked = prefs.getBool(_keyCheatUnlocked) ?? false;
    final isPremium = prefs.getBool(_keyPremium) ?? false;
    final questionsAnswered = prefs.getInt(_keyQuestionsAnswered) ?? 0;

    Map<String, double> scores = {};
    final scoresJson = prefs.getString(_keyLessonScores);
    if (scoresJson != null && scoresJson.isNotEmpty) {
      try {
        final decoded = jsonDecode(scoresJson) as Map<String, dynamic>;
        scores = decoded.map((k, v) => MapEntry(k, (v as num).toDouble()));
      } catch (_) {}
    } else {
      // Backwards compatibility: completed lessons default to 100.0
      for (final id in completed) {
        scores[id] = 100.0;
      }
    }

    // Günlük streak kontrolü
    final today = _todayString();
    int activeStreak = streak;
    if (lastDate.isNotEmpty && lastDate != today) {
      final lastDateTime = DateTime.tryParse(lastDate);
      if (lastDateTime != null) {
        final diffInDays = DateTime.now().difference(lastDateTime).inDays;
        if (diffInDays > 1) {
          activeStreak = 0; // Seri kırıldı
        }
      }
    }

    state = state.copyWith(
      hearts: hearts,
      streak: activeStreak,
      xp: xp,
      gems: gems,
      completedLessonIds: completed,
      lessonScores: scores,
      lastActiveDate: lastDate,
      isCheatUnlocked: isCheatUnlocked,
      isPremium: isPremium,
      questionsAnsweredCount: questionsAnswered,
    );
  }

  String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> _saveToPrefs() async {
    final current = state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyHearts, current.hearts);
    await prefs.setInt(_keyStreak, current.streak);
    await prefs.setInt(_keyXp, current.xp);
    await prefs.setInt(_keyGems, current.gems);
    await prefs.setStringList(_keyCompletedLessons, current.completedLessonIds.toList());
    await prefs.setString(_keyLessonScores, jsonEncode(current.lessonScores));
    await prefs.setString(_keyLastDate, current.lastActiveDate);
    await prefs.setBool(_keyCheatUnlocked, current.isCheatUnlocked);
    await prefs.setBool(_keyPremium, current.isPremium);
    await prefs.setInt(_keyQuestionsAnswered, current.questionsAnsweredCount);
  }

  bool incrementQuestionsAnswered() {
    final nextCount = state.questionsAnsweredCount + 1;
    state = state.copyWith(questionsAnsweredCount: nextCount);
    _saveToPrefs();
    // Her 10 soruda bir reklam molası (Premium kullanıcılar hariç)
    return !state.isPremium && (nextCount % 10 == 0);
  }

  void loseHeart() {
    if (state.isPremium) return; // Premium: Sınırsız Can!
    if (state.hearts > 0) {
      state = state.copyWith(hearts: state.hearts - 1);
      _saveToPrefs();
    }
  }

  void activatePremium() {
    state = state.copyWith(
      isPremium: true,
      hearts: state.maxHearts,
    );
    _saveToPrefs();
  }

  void deactivatePremium() {
    state = state.copyWith(
      isPremium: false,
      isCheatUnlocked: false,
      hearts: state.maxHearts,
    );
    _saveToPrefs();
  }

  void addGems(int amount) {
    if (amount > 0) {
      state = state.copyWith(gems: state.gems + amount);
      _saveToPrefs();
    }
  }

  void gainHeart() {
    if (state.hearts < state.maxHearts) {
      state = state.copyWith(hearts: state.hearts + 1);
      _saveToPrefs();
    }
  }

  bool buyOneHeartWithGems() {
    if (state.gems >= 50) {
      state = state.copyWith(
        hearts: (state.hearts + 1).clamp(0, state.maxHearts),
        gems: state.gems - 50,
      );
      _saveToPrefs();
      return true;
    }
    return false;
  }

  void addHeartFromAd() {
    state = state.copyWith(
      hearts: (state.hearts + 1).clamp(0, state.maxHearts),
    );
    _saveToPrefs();
  }

  bool refillHearts({bool withGems = false}) {
    if (withGems) {
      if (state.gems >= 50) {
        state = state.copyWith(
          hearts: state.maxHearts,
          gems: state.gems - 50,
        );
        _saveToPrefs();
        return true;
      }
      return false;
    } else {
      state = state.copyWith(hearts: state.maxHearts);
      _saveToPrefs();
      return true;
    }
  }

  void recordLessonAttempt(Lesson lesson, double accuracy) {
    final today = _todayString();
    int newStreak = state.streak;

    final newScores = Map<String, double>.from(state.lessonScores);
    final previousScore = newScores[lesson.id] ?? 0.0;
    // En yüksek başarı oranını kaydet, henüz geçilmediyse en son skoru tut
    if (accuracy > previousScore || !state.completedLessonIds.contains(lesson.id)) {
      newScores[lesson.id] = accuracy;
    }

    Set<String> newCompleted = Set<String>.from(state.completedLessonIds);
    int newXp = state.xp;
    int newGems = state.gems;

    if (accuracy >= 50.0) {
      if (state.lastActiveDate != today) {
        newStreak += 1;
      }
      if (!newCompleted.contains(lesson.id)) {
        newCompleted.add(lesson.id);
        newXp += lesson.xpReward;
        newGems += lesson.gemReward;
      }
    }

    state = state.copyWith(
      xp: newXp,
      gems: newGems,
      streak: newStreak,
      lastActiveDate: accuracy >= 50.0 ? today : state.lastActiveDate,
      completedLessonIds: newCompleted,
      lessonScores: newScores,
    );
    _saveToPrefs();
  }

  void completeLesson(Lesson lesson) {
    recordLessonAttempt(lesson, 100.0);
  }

  void resetAllProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = const UserProfile();
  }

  PromoResult applyPromoCode(String rawCode) {
    final code = rawCode.trim().toLowerCase();
    if (code.isEmpty) {
      return const PromoResult(
        success: false,
        message: 'Lütfen bir promosyon veya indirim kodu girin.',
      );
    }

    // 🚀 KULLANICININ ÖZEL HİLE & PREMİUM KODU: kagan123
    // Tekrar yazınca hile modu ve Premium kapanır, canlı moda döner!
    if (code == 'kagan123') {
      if (state.isCheatUnlocked || state.isPremium) {
        state = state.copyWith(
          isCheatUnlocked: false,
          isPremium: false,
          hearts: state.maxHearts,
        );
        _saveToPrefs();
        return const PromoResult(
          success: true,
          isCheat: false,
          message: '🛡️ Kagan Hile & Premium Kapatıldı!\n'
              '❤️ Tekrardan 5 can ile normal canlı moda döndün.\n'
              '⚡ Sınırsız can ve otomatik işaretleme kapatıldı.',
        );
      } else {
        state = state.copyWith(
          hearts: state.maxHearts,
          gems: 300,
          isCheatUnlocked: true,
        );
        _saveToPrefs();
        return PromoResult(
          success: true,
          isCheat: true,
          hearts: state.maxHearts,
          gems: 300,
          message: '🔥 Kagan Özel Hile Kodu Devreye Girdi!\n'
              '❤️ Canların maksimuma (${state.maxHearts}/${state.maxHearts}) çıkarıldı!\n'
              '💎 Elmasın tam 300 yapıldı!\n'
              '⚡ Otomatik Doğru İşaretleme Hilesi Aktif Edildi!\n'
              '(Kapatmak için tekrar kagan123 veya "kapat" yazabilirsin)',
        );
      }
    }

    // 🔒 KAPAT KODU: "kapat"
    if (code == 'kapat' || code == 'premium kapat' || code == 'kagan kapat' || code == 'premiumkapat' || code == 'hilekapat') {
      state = state.copyWith(
        isPremium: false,
        isCheatUnlocked: false,
        hearts: state.maxHearts,
      );
      _saveToPrefs();
      return const PromoResult(
        success: true,
        isCheat: false,
        message: '🔒 Premium ve Hile Kapatıldı!\n'
            '❤️ Tekrardan 5 can ile normal canlı moda döndün.\n'
            'Artık yanlış cevaplarda canın azalacak.',
      );
    }

    // 🎁 STANDART İNDİRİM & PROMOSYON KODLARI
    if (code == 'yks2026' || code == 'indirim' || code == 'indirim50') {
      state = state.copyWith(
        hearts: state.maxHearts,
        gems: state.gems + 150,
      );
      _saveToPrefs();
      return PromoResult(
        success: true,
        hearts: state.maxHearts,
        gems: state.gems,
        message: '🎉 %50 İndirim & Destek Kodu Uygulandı!\n'
            '❤️ Canların tamamen yenilendi!\n'
            '💎 Hesabına +150 Elmas eklendi!',
      );
    }

    if (code == 'tampuan' || code == 'derece') {
      state = state.copyWith(
        hearts: state.maxHearts,
        gems: state.gems + 200,
        xp: state.xp + 50,
      );
      _saveToPrefs();
      return PromoResult(
        success: true,
        hearts: state.maxHearts,
        gems: state.gems,
        message: '🏆 Derece Kodu Aktif!\n'
            '❤️ Canlar dolduruldu!\n'
            '💎 +200 Elmas & +50 XP yüklendi!',
      );
    }

    return const PromoResult(
      success: false,
      message: 'Geçersiz veya süresi dolmuş promosyon kodu.',
    );
  }
}

class PromoResult {
  final bool success;
  final String message;
  final bool isCheat;
  final int? hearts;
  final int? gems;

  const PromoResult({
    required this.success,
    required this.message,
    this.isCheat = false,
    this.hearts,
    this.gems,
  });
}

