import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  static const String _keyClaimedAchievements = 'user_claimed_achievements';

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
    final claimedAchievements =
        prefs.getStringList(_keyClaimedAchievements)?.toSet() ?? {};

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
      claimedAchievementIds: claimedAchievements,
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
    await prefs.setStringList(_keyClaimedAchievements, current.claimedAchievementIds.toList());
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

  /// Başarım ödülünü toplar (Elmas ve XP ekler)
  bool claimAchievement(String id, int gemReward, int xpReward) {
    if (state.claimedAchievementIds.contains(id)) return false;
    final updatedClaimed = Set<String>.from(state.claimedAchievementIds)..add(id);
    state = state.copyWith(
      claimedAchievementIds: updatedClaimed,
      gems: state.gems + gemReward,
      xp: state.xp + xpReward,
    );
    _saveToPrefs();
    return true;
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

/// Kullanıcının anlık verilerine göre dinamik hesaplanan 18 zengin başarım ve rozet listesi
final achievementsProvider = Provider<List<Achievement>>((ref) {
  final user = ref.watch(userProfileProvider);
  final completedCount = user.completedLessonIds.length;
  final trophiesCount = user.completedLessonIds
      .where((id) => id.contains('trophy') || id.contains('kupa'))
      .length;
  final perfectCount =
      user.lessonScores.values.where((score) => score >= 99.9).length;
  final currentHour = DateTime.now().hour;
  final isNight = currentHour >= 22 || currentHour < 5;
  final isMorning = currentHour >= 5 && currentHour < 9;

  return [
    // 1. Seri Başarımları
    Achievement(
      id: 'streak_3',
      title: 'Seri Başlatıcı',
      desc: '3 gün üst üste soru çözerek çalışma alışkanlığı kazan',
      iconEmoji: '🔥',
      category: AchievementCategory.streak,
      currentProgress: user.streak.clamp(0, 3),
      maxProgress: 3,
      tier: 1,
      gemReward: 20,
      xpReward: 50,
      isUnlocked: user.streak >= 3,
      isClaimed: user.claimedAchievementIds.contains('streak_3'),
    ),
    Achievement(
      id: 'streak_7',
      title: 'Alev Topu',
      desc: '7 gün kesintisiz çalışma serisi yakala',
      iconEmoji: '⚡',
      category: AchievementCategory.streak,
      currentProgress: user.streak.clamp(0, 7),
      maxProgress: 7,
      tier: 2,
      gemReward: 50,
      xpReward: 100,
      isUnlocked: user.streak >= 7,
      isClaimed: user.claimedAchievementIds.contains('streak_7'),
    ),
    Achievement(
      id: 'streak_30',
      title: 'Durdurulamaz Maraton',
      desc: 'Tam 30 gün boyunca her gün YKS Patika ile çalış',
      iconEmoji: '🌋',
      category: AchievementCategory.streak,
      currentProgress: user.streak.clamp(0, 30),
      maxProgress: 30,
      tier: 3,
      gemReward: 200,
      xpReward: 300,
      isUnlocked: user.streak >= 30,
      isClaimed: user.claimedAchievementIds.contains('streak_30'),
    ),

    // 2. Ders & Konu Başarımları
    Achievement(
      id: 'lessons_1',
      title: 'İlk Adım',
      desc: 'İlk YKS dersini başarıyla tamamla',
      iconEmoji: '🎯',
      category: AchievementCategory.lessons,
      currentProgress: completedCount > 0 ? 1 : 0,
      maxProgress: 1,
      tier: 1,
      gemReward: 15,
      xpReward: 30,
      isUnlocked: completedCount >= 1,
      isClaimed: user.claimedAchievementIds.contains('lessons_1'),
    ),
    Achievement(
      id: 'lessons_5',
      title: 'Konu Çaylağı',
      desc: 'Toplam 5 farklı konuyu başarıyla bitir',
      iconEmoji: '📖',
      category: AchievementCategory.lessons,
      currentProgress: completedCount.clamp(0, 5),
      maxProgress: 5,
      tier: 1,
      gemReward: 25,
      xpReward: 60,
      isUnlocked: completedCount >= 5,
      isClaimed: user.claimedAchievementIds.contains('lessons_5'),
    ),
    Achievement(
      id: 'lessons_15',
      title: 'Konu Avcısı',
      desc: 'Toplam 15 farklı konuyu geride bırak',
      iconEmoji: '📚',
      category: AchievementCategory.lessons,
      currentProgress: completedCount.clamp(0, 15),
      maxProgress: 15,
      tier: 2,
      gemReward: 60,
      xpReward: 150,
      isUnlocked: completedCount >= 15,
      isClaimed: user.claimedAchievementIds.contains('lessons_15'),
    ),
    Achievement(
      id: 'lessons_35',
      title: 'YKS Bilgesi',
      desc: '35 farklı dersi tamamlayarak dev bir bilgi birikimi yap',
      iconEmoji: '🎓',
      category: AchievementCategory.lessons,
      currentProgress: completedCount.clamp(0, 35),
      maxProgress: 35,
      tier: 3,
      gemReward: 120,
      xpReward: 250,
      isUnlocked: completedCount >= 35,
      isClaimed: user.claimedAchievementIds.contains('lessons_35'),
    ),
    Achievement(
      id: 'lessons_70',
      title: 'Derece Adayı',
      desc: '70 farklı dersi bitirerek zirveye oyna',
      iconEmoji: '🏛️',
      category: AchievementCategory.lessons,
      currentProgress: completedCount.clamp(0, 70),
      maxProgress: 70,
      tier: 3,
      gemReward: 300,
      xpReward: 500,
      isUnlocked: completedCount >= 70,
      isClaimed: user.claimedAchievementIds.contains('lessons_70'),
    ),

    // 3. Kupa & Ünite Sınavı Başarımları
    Achievement(
      id: 'trophy_1',
      title: 'İlk Şampiyonluk',
      desc: 'İlk ünite sonu kupa sınavını başarıyla geç',
      iconEmoji: '🏆',
      category: AchievementCategory.trophies,
      currentProgress: trophiesCount > 0 ? 1 : 0,
      maxProgress: 1,
      tier: 1,
      gemReward: 30,
      xpReward: 80,
      isUnlocked: trophiesCount >= 1,
      isClaimed: user.claimedAchievementIds.contains('trophy_1'),
    ),
    Achievement(
      id: 'trophy_5',
      title: 'Kupa Koleksiyoncusu',
      desc: '5 farklı ünite şampiyonluk kupası kazan',
      iconEmoji: '👑',
      category: AchievementCategory.trophies,
      currentProgress: trophiesCount.clamp(0, 5),
      maxProgress: 5,
      tier: 2,
      gemReward: 80,
      xpReward: 200,
      isUnlocked: trophiesCount >= 5,
      isClaimed: user.claimedAchievementIds.contains('trophy_5'),
    ),
    Achievement(
      id: 'trophy_15',
      title: 'Kupa Şampiyonu',
      desc: '15 farklı ünitede altın kupayı havaya kaldır',
      iconEmoji: '⭐',
      category: AchievementCategory.trophies,
      currentProgress: trophiesCount.clamp(0, 15),
      maxProgress: 15,
      tier: 3,
      gemReward: 200,
      xpReward: 400,
      isUnlocked: trophiesCount >= 15,
      isClaimed: user.claimedAchievementIds.contains('trophy_15'),
    ),

    // 4. Ustalık & Doğruluk
    Achievement(
      id: 'perfect_1',
      title: 'Kusursuz Net',
      desc: 'Bir dersi %100 tam doğrulukla sıfır hatayla bitir',
      iconEmoji: '💯',
      category: AchievementCategory.mastery,
      currentProgress: perfectCount > 0 ? 1 : 0,
      maxProgress: 1,
      tier: 1,
      gemReward: 25,
      xpReward: 50,
      isUnlocked: perfectCount >= 1,
      isClaimed: user.claimedAchievementIds.contains('perfect_1'),
    ),
    Achievement(
      id: 'perfect_5',
      title: 'Keskin Nişancı',
      desc: '5 farklı derste %100 tam puan al',
      iconEmoji: '🎯',
      category: AchievementCategory.mastery,
      currentProgress: perfectCount.clamp(0, 5),
      maxProgress: 5,
      tier: 2,
      gemReward: 75,
      xpReward: 150,
      isUnlocked: perfectCount >= 5,
      isClaimed: user.claimedAchievementIds.contains('perfect_5'),
    ),
    Achievement(
      id: 'steel_heart',
      title: 'Çelik Can',
      desc: '5 tam canını hiç kaybetmeden bir dersi tamamla',
      iconEmoji: '🛡️',
      category: AchievementCategory.mastery,
      currentProgress: (user.hearts >= 5 && completedCount > 0) ? 1 : 0,
      maxProgress: 1,
      tier: 1,
      gemReward: 30,
      xpReward: 60,
      isUnlocked: user.hearts >= 5 && completedCount > 0,
      isClaimed: user.claimedAchievementIds.contains('steel_heart'),
    ),

    // 5. Elmas & Hazine
    Achievement(
      id: 'gems_200',
      title: 'Elmas Zengini',
      desc: 'Toplam 200 Elmas biriktir',
      iconEmoji: '💎',
      category: AchievementCategory.gems,
      currentProgress: user.gems.clamp(0, 200),
      maxProgress: 200,
      tier: 1,
      gemReward: 40,
      xpReward: 80,
      isUnlocked: user.gems >= 200,
      isClaimed: user.claimedAchievementIds.contains('gems_200'),
    ),
    Achievement(
      id: 'gems_500',
      title: 'Hazine Avcısı',
      desc: 'Toplam 500 Elmas biriktir',
      iconEmoji: '💰',
      category: AchievementCategory.gems,
      currentProgress: user.gems.clamp(0, 500),
      maxProgress: 500,
      tier: 2,
      gemReward: 100,
      xpReward: 200,
      isUnlocked: user.gems >= 500,
      isClaimed: user.claimedAchievementIds.contains('gems_500'),
    ),
    Achievement(
      id: 'xp_500',
      title: '500 XP Kulübü',
      desc: '500 XP toplayarak liglerde öne geç',
      iconEmoji: '⚡',
      category: AchievementCategory.gems,
      currentProgress: user.xp.clamp(0, 500),
      maxProgress: 500,
      tier: 2,
      gemReward: 50,
      xpReward: 100,
      isUnlocked: user.xp >= 500,
      isClaimed: user.claimedAchievementIds.contains('xp_500'),
    ),

    // 6. Özel & Çalışma Rutini
    Achievement(
      id: 'night_owl',
      title: 'Gece Kuşu',
      desc: 'Saat 22:00\'den sonra gece etüdü yaparak ders çöz',
      iconEmoji: '🦉',
      category: AchievementCategory.special,
      currentProgress: (isNight && completedCount > 0) ? 1 : 0,
      maxProgress: 1,
      tier: 1,
      gemReward: 35,
      xpReward: 70,
      isUnlocked: isNight && completedCount > 0,
      isClaimed: user.claimedAchievementIds.contains('night_owl'),
    ),
    Achievement(
      id: 'early_bird',
      title: 'Erken Kalkan',
      desc: 'Sabah 08:00\'den önce erken saatte ders çöz',
      iconEmoji: '🌅',
      category: AchievementCategory.special,
      currentProgress: (isMorning && completedCount > 0) ? 1 : 0,
      maxProgress: 1,
      tier: 1,
      gemReward: 35,
      xpReward: 70,
      isUnlocked: isMorning && completedCount > 0,
      isClaimed: user.claimedAchievementIds.contains('early_bird'),
    ),
    Achievement(
      id: 'questions_100',
      title: 'Soru Canavarı',
      desc: 'Toplam 100 soru çözerek pratikliğini kanıtla',
      iconEmoji: '🎯',
      category: AchievementCategory.special,
      currentProgress: user.questionsAnsweredCount.clamp(0, 100),
      maxProgress: 100,
      tier: 2,
      gemReward: 70,
      xpReward: 150,
      isUnlocked: user.questionsAnsweredCount >= 100,
      isClaimed: user.claimedAchievementIds.contains('questions_100'),
    ),
  ];
});


