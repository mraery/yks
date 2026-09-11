enum QuestionType {
  conceptCard,
  multipleChoice,
  matching,
  trueFalse,
  fillInTheBlank,
}

class MatchingPair {
  final String left;
  final String right;

  const MatchingPair({required this.left, required this.right});
}

class Question {
  final String id;
  final QuestionType type;
  final String prompt;
  final String? passage; // Opsiyonel paragraf veya metin
  final List<String>? options;
  final int? correctIndex;
  final String explanation;
  final List<MatchingPair>? matchingPairs;
  final bool? isTrue;

  // Boşluk Doldurma Alanları
  final List<String>? blankOptions; // Seçilebilecek kelimeler havuzu
  final String? correctBlankAnswer; // Doğru kelime

  // Görsel ve Şema Alanları (Biyoloji, Coğrafya vb.)
  final String? diagramType; // 'cell_organelles', 'mitochondria', 'food_pyramid', 'enzyme_lock', 'dna_helix'
  final String? imageUrl;

  // Konu Anlatım / Hap Bilgi Kartı Alanları
  final String? conceptTitle;
  final String? rule; // Kural ve Tanım
  final List<String>? examples; // Örnekler ve Açıklamaları
  final String? examTip; // ÖSYM Sınav Taktiği / Püf Noktası
  final String? iconEmoji; // 💡, ⚡, 🔍, 📖

  const Question({
    required this.id,
    required this.type,
    this.prompt = '',
    this.passage,
    this.options,
    this.correctIndex,
    this.explanation = '',
    this.matchingPairs,
    this.isTrue,
    this.blankOptions,
    this.correctBlankAnswer,
    this.diagramType,
    this.imageUrl,
    this.conceptTitle,
    this.rule,
    this.examples,
    this.examTip,
    this.iconEmoji,
  });
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final int gemReward;
  final List<Question> questions;
  final bool isUnitExam; // Ünite Sonu Kupa / Final Sınavı mı?

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    this.xpReward = 50,
    this.gemReward = 10,
    required this.questions,
    this.isUnitExam = false,
  });
}

class LearningUnit {
  final String id;
  final int unitNumber;
  final String title;
  final String subject; // "TYT Türkçe", "TYT Tarih"
  final int colorHex;
  final List<Lesson> lessons;

  const LearningUnit({
    required this.id,
    required this.unitNumber,
    required this.title,
    required this.subject,
    required this.colorHex,
    required this.lessons,
  });
}

enum AchievementCategory {
  streak,
  lessons,
  trophies,
  mastery,
  gems,
  special,
}

class Achievement {
  final String id;
  final String title;
  final String desc;
  final String iconEmoji;
  final AchievementCategory category;
  final int currentProgress;
  final int maxProgress;
  final int tier; // 1, 2, 3
  final int gemReward;
  final int xpReward;
  final bool isUnlocked;
  final bool isClaimed;

  const Achievement({
    required this.id,
    required this.title,
    required this.desc,
    required this.iconEmoji,
    required this.category,
    required this.currentProgress,
    required this.maxProgress,
    this.tier = 1,
    this.gemReward = 20,
    this.xpReward = 50,
    required this.isUnlocked,
    this.isClaimed = false,
  });

  double get progressRatio =>
      maxProgress > 0 ? (currentProgress / maxProgress).clamp(0.0, 1.0) : 0.0;
}

class UserProfile {
  final int hearts;
  final int maxHearts;
  final int streak;
  final String lastActiveDate;
  final int xp;
  final int gems;
  final Set<String> completedLessonIds;
  final Map<String, double> lessonScores;
  final bool isCheatUnlocked;
  final bool isPremium;
  final int questionsAnsweredCount;
  final Set<String> claimedAchievementIds;

  const UserProfile({
    this.hearts = 5,
    this.maxHearts = 5,
    this.streak = 0,
    this.lastActiveDate = '',
    this.xp = 0,
    this.gems = 100,
    this.completedLessonIds = const {},
    this.lessonScores = const {},
    this.isCheatUnlocked = false,
    this.isPremium = false,
    this.questionsAnsweredCount = 0,
    this.claimedAchievementIds = const {},
  });

  UserProfile copyWith({
    int? hearts,
    int? maxHearts,
    int? streak,
    String? lastActiveDate,
    int? xp,
    int? gems,
    Set<String>? completedLessonIds,
    Map<String, double>? lessonScores,
    bool? isCheatUnlocked,
    bool? isPremium,
    int? questionsAnsweredCount,
    Set<String>? claimedAchievementIds,
  }) {
    return UserProfile(
      hearts: hearts ?? this.hearts,
      maxHearts: maxHearts ?? this.maxHearts,
      streak: streak ?? this.streak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      xp: xp ?? this.xp,
      gems: gems ?? this.gems,
      completedLessonIds: completedLessonIds ?? this.completedLessonIds,
      lessonScores: lessonScores ?? this.lessonScores,
      isCheatUnlocked: isCheatUnlocked ?? this.isCheatUnlocked,
      isPremium: isPremium ?? this.isPremium,
      questionsAnsweredCount:
          questionsAnsweredCount ?? this.questionsAnsweredCount,
      claimedAchievementIds:
          claimedAchievementIds ?? this.claimedAchievementIds,
    );
  }
}

class Flashcard {
  final String id;
  final String term;
  final String meaning;
  final String subject;
  final String? category;
  final String? example;
  final String? examTip;

  const Flashcard({
    required this.id,
    required this.term,
    required this.meaning,
    required this.subject,
    this.category,
    this.example,
    this.examTip,
  });
}

