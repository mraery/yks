
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

  Map<String, dynamic> toJson() => {'left': left, 'right': right};

  factory MatchingPair.fromJson(Map<String, dynamic> json) => MatchingPair(
        left: json['left']?.toString() ?? '',
        right: json['right']?.toString() ?? '',
      );
}

class Question {
  final String id;
  final QuestionType type;
  final String prompt;
  final String? passage;
  final List<String>? options;
  final int? correctIndex;
  final String explanation;
  final List<MatchingPair>? matchingPairs;
  final bool? isTrue;

  // Bosluk Doldurma Alanlari
  final List<String>? blankOptions;
  final String? correctBlankAnswer;

  // Gorsel ve Sema Alanlari
  final String? diagramType;
  final String? imageUrl;

  // Konu Anlatim / Hap Bilgi Karti Alanlari
  final String? conceptTitle;
  final String? rule;
  final List<String>? examples;
  final String? examTip;
  final String? iconEmoji;

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'prompt': prompt,
        if (passage != null) 'passage': passage,
        if (options != null) 'options': options,
        if (correctIndex != null) 'correctIndex': correctIndex,
        'explanation': explanation,
        if (matchingPairs != null)
          'matchingPairs': matchingPairs!.map((p) => p.toJson()).toList(),
        if (isTrue != null) 'isTrue': isTrue,
        if (blankOptions != null) 'blankOptions': blankOptions,
        if (correctBlankAnswer != null)
          'correctBlankAnswer': correctBlankAnswer,
        if (diagramType != null) 'diagramType': diagramType,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (conceptTitle != null) 'conceptTitle': conceptTitle,
        if (rule != null) 'rule': rule,
        if (examples != null) 'examples': examples,
        if (examTip != null) 'examTip': examTip,
        if (iconEmoji != null) 'iconEmoji': iconEmoji,
      };

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id']?.toString() ?? '',
      type: QuestionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => QuestionType.multipleChoice,
      ),
      prompt: json['prompt']?.toString() ?? '',
      passage: json['passage']?.toString(),
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      correctIndex: json['correctIndex'] as int?,
      explanation: json['explanation']?.toString() ?? '',
      matchingPairs: (json['matchingPairs'] as List<dynamic>?)
          ?.map((p) => MatchingPair.fromJson(p as Map<String, dynamic>))
          .toList(),
      isTrue: json['isTrue'] as bool?,
      blankOptions: (json['blankOptions'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      correctBlankAnswer: json['correctBlankAnswer']?.toString(),
      diagramType: json['diagramType']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      conceptTitle: json['conceptTitle']?.toString(),
      rule: json['rule']?.toString(),
      examples: (json['examples'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      examTip: json['examTip']?.toString(),
      iconEmoji: json['iconEmoji']?.toString(),
    );
  }
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final int gemReward;
  final List<Question> questions;
  final bool isUnitExam;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    this.xpReward = 50,
    this.gemReward = 10,
    required this.questions,
    this.isUnitExam = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'xpReward': xpReward,
        'gemReward': gemReward,
        'questions': questions.map((q) => q.toJson()).toList(),
        'isUnitExam': isUnitExam,
      };

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      xpReward: json['xpReward'] as int? ?? 50,
      gemReward: json['gemReward'] as int? ?? 10,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((q) => Question.fromJson(q as Map<String, dynamic>))
              .toList() ??
          [],
      isUnitExam: json['isUnitExam'] as bool? ?? false,
    );
  }
}

class LearningUnit {
  final String id;
  final int unitNumber;
  final String title;
  final String subject;
  final int colorHex;
  final List<Lesson> lessons;
  final bool isDownloaded;

  const LearningUnit({
    required this.id,
    required this.unitNumber,
    required this.title,
    required this.subject,
    required this.colorHex,
    required this.lessons,
    this.isDownloaded = false,
  });

  bool get isLoaded =>
      lessons.isNotEmpty && lessons.any((l) => l.questions.isNotEmpty);

  LearningUnit copyWith({
    String? id,
    int? unitNumber,
    String? title,
    String? subject,
    int? colorHex,
    List<Lesson>? lessons,
    bool? isDownloaded,
  }) {
    return LearningUnit(
      id: id ?? this.id,
      unitNumber: unitNumber ?? this.unitNumber,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      colorHex: colorHex ?? this.colorHex,
      lessons: lessons ?? this.lessons,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }

  LearningUnit toSkeleton() {
    return LearningUnit(
      id: id,
      unitNumber: unitNumber,
      title: title,
      subject: subject,
      colorHex: colorHex,
      isDownloaded: false,
      lessons: lessons
          .map(
            (l) => Lesson(
              id: l.id,
              title: l.title,
              description: l.description,
              xpReward: l.xpReward,
              gemReward: l.gemReward,
              questions: const [],
              isUnitExam: l.isUnitExam,
            ),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'unitNumber': unitNumber,
        'title': title,
        'subject': subject,
        'colorHex': colorHex,
        'lessons': lessons.map((l) => l.toJson()).toList(),
      };

  factory LearningUnit.fromJson(Map<String, dynamic> json,
      {bool isDownloaded = true}) {
    return LearningUnit(
      id: json['id']?.toString() ?? '',
      unitNumber: json['unitNumber'] as int? ?? 1,
      title: json['title']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      colorHex: json['colorHex'] as int? ?? 0xFF4F46E5,
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((l) => Lesson.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
      isDownloaded: isDownloaded,
    );
  }
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
  final int tier;
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'term': term,
        'meaning': meaning,
        'subject': subject,
        if (category != null) 'category': category,
        if (example != null) 'example': example,
        if (examTip != null) 'examTip': examTip,
      };

  factory Flashcard.fromJson(Map<String, dynamic> json) => Flashcard(
        id: json['id']?.toString() ?? '',
        term: json['term']?.toString() ?? '',
        meaning: json['meaning']?.toString() ?? '',
        subject: json['subject']?.toString() ?? '',
        category: json['category']?.toString(),
        example: json['example']?.toString(),
        examTip: json['examTip']?.toString(),
      );
}
