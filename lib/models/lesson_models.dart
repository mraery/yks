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

class UserProfile {
  final int hearts;
  final int maxHearts;
  final int streak;
  final String lastActiveDate;
  final int xp;
  final int gems;
  final Set<String> completedLessonIds;
  final Map<String, double> lessonScores;

  const UserProfile({
    this.hearts = 5,
    this.maxHearts = 5,
    this.streak = 0,
    this.lastActiveDate = '',
    this.xp = 0,
    this.gems = 100,
    this.completedLessonIds = const {},
    this.lessonScores = const {},
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
    );
  }
}
