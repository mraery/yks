import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ykslingo/data/mock_lessons.dart';
import 'package:ykslingo/models/lesson_models.dart';
import 'package:ykslingo/providers/game_provider.dart';
import 'package:ykslingo/providers/quiz_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Mock lessons feature concept cards and test questions', () {
    final lesson = mockUnits[0].lessons[0];
    expect(lesson.questions.isNotEmpty, true);
    
    // Check that concept card exists
    final conceptCard = lesson.questions.firstWhere((q) => q.type == QuestionType.conceptCard);
    expect(conceptCard.conceptTitle, isNotNull);
    expect(conceptCard.rule, isNotEmpty);
    expect(conceptCard.examTip, isNotEmpty);

    // Check that test questions exist
    expect(lesson.questions.any((q) => q.type == QuestionType.multipleChoice), true);
  });

  test('QuizNotifier advances concept card without losing hearts and without incrementing correctCount', () {
    final container = ProviderContainer();
    final customLesson = Lesson(
      id: 'test_card_adv',
      title: 'Card Adv',
      description: 'Test',
      questions: [
        Question(
          id: 'card_1',
          type: QuestionType.conceptCard,
          conceptTitle: 'Taktik',
          rule: 'Kural',
          examTip: 'İpucu',
        ),
        Question(
          id: 'q1',
          type: QuestionType.multipleChoice,
          prompt: 'Soru 1',
          options: ['A', 'B'],
          correctIndex: 0,
        ),
      ],
    );
    final notifier = container.read(quizProvider(customLesson).notifier);

    // Initial state
    expect(container.read(quizProvider(customLesson)).currentIndex, 0);
    expect(container.read(quizProvider(customLesson)).correctCount, 0);
    expect(container.read(userProfileProvider).hearts, 5);

    // Advance concept card
    notifier.advanceConceptCard();

    // Now at question 1, hearts still 5, correctCount still 0
    expect(container.read(quizProvider(customLesson)).currentIndex, 1);
    expect(container.read(quizProvider(customLesson)).correctCount, 0);
    expect(container.read(userProfileProvider).hearts, 5);
  });

  test('Concept cards do not award score, answering 0 questions correctly yields 0% and fails', () {
    final container = ProviderContainer();
    final customLesson = Lesson(
      id: 'test_zero_score_lesson',
      title: 'Zero Score Test',
      description: 'Test',
      questions: [
        Question(
          id: 'card_1',
          type: QuestionType.conceptCard,
          conceptTitle: 'Taktik',
          rule: 'Kural',
          examTip: 'İpucu',
        ),
        Question(
          id: 'q1',
          type: QuestionType.multipleChoice,
          prompt: 'Soru 1',
          options: ['A', 'B'],
          correctIndex: 0,
        ),
        Question(
          id: 'q2',
          type: QuestionType.multipleChoice,
          prompt: 'Soru 2',
          options: ['A', 'B'],
          correctIndex: 0,
        ),
      ],
    );

    final notifier = container.read(quizProvider(customLesson).notifier);

    // Step 0: Concept Card
    notifier.advanceConceptCard();
    expect(container.read(quizProvider(customLesson)).correctCount, 0);

    // Step 1: Wrong answer
    notifier.selectOption(1);
    notifier.checkAnswer();
    notifier.nextQuestion();

    // Step 2: Wrong answer
    notifier.selectOption(1);
    notifier.checkAnswer();
    notifier.nextQuestion();

    final state = container.read(quizProvider(customLesson));
    expect(state.isQuizComplete, true);
    expect(state.correctCount, 0);
    expect(state.totalTestQuestions, 2);
    expect(state.accuracy, 0.0);
    expect(state.isPassed, false);

    // Profile check
    final profile = container.read(userProfileProvider);
    expect(profile.completedLessonIds.contains('test_zero_score_lesson'), false);
    expect(profile.lessonScores['test_zero_score_lesson'], 0.0);
  });

  test('Each unit contains a Unit Exam Trophy lesson', () {
    for (final unit in mockUnits) {
      final hasExam = unit.lessons.any((l) => l.isUnitExam);
      expect(hasExam, true, reason: 'Unit ${unit.id} should have a Unit Exam lesson');
    }
  });

  test('QuizNotifier handles fillInTheBlank questions correctly', () {
    final container = ProviderContainer();
    final examLesson = mockUnits[0].lessons.firstWhere((l) => l.isUnitExam);
    final blankQ = examLesson.questions.firstWhere((q) => q.type == QuestionType.fillInTheBlank);
    
    final customLesson = Lesson(
      id: 'test_blank_lesson',
      title: 'Test Blank',
      description: 'Test',
      questions: [blankQ],
    );

    final notifier = container.read(quizProvider(customLesson).notifier);
    expect(container.read(quizProvider(customLesson)).canCheckAnswer, false);

    // Select the correct blank word
    notifier.selectBlankAnswer(blankQ.correctBlankAnswer);
    expect(container.read(quizProvider(customLesson)).canCheckAnswer, true);

    // Check answer
    notifier.checkAnswer();
    expect(container.read(quizProvider(customLesson)).isAnswerChecked, true);
    expect(container.read(quizProvider(customLesson)).isAnswerCorrect, true);
    expect(container.read(userProfileProvider).hearts, 5);
  });

  test('QuizNotifier strictly enforces 50% passing threshold for lesson completion', () {
    final container = ProviderContainer();
    final dummyQuestions = [
      Question(id: 'q1', type: QuestionType.multipleChoice, prompt: 'Soru 1', options: ['A', 'B'], correctIndex: 0),
      Question(id: 'q2', type: QuestionType.multipleChoice, prompt: 'Soru 2', options: ['A', 'B'], correctIndex: 0),
      Question(id: 'q3', type: QuestionType.multipleChoice, prompt: 'Soru 3', options: ['A', 'B'], correctIndex: 0),
      Question(id: 'q4', type: QuestionType.multipleChoice, prompt: 'Soru 4', options: ['A', 'B'], correctIndex: 0),
    ];
    final testLesson = Lesson(
      id: 'test_threshold_lesson',
      title: 'Threshold Test',
      description: 'Threshold Test',
      questions: dummyQuestions,
    );

    final notifier = container.read(quizProvider(testLesson).notifier);

    // Answer 1 correct (25%), 3 wrong -> accuracy 25% < 50%
    notifier.selectOption(0); // correct
    notifier.checkAnswer();
    notifier.nextQuestion();

    notifier.selectOption(1); // wrong
    notifier.checkAnswer();
    notifier.nextQuestion();

    notifier.selectOption(1); // wrong
    notifier.checkAnswer();
    notifier.nextQuestion();

    notifier.selectOption(1); // wrong
    notifier.checkAnswer();
    notifier.nextQuestion();

    final quizState = container.read(quizProvider(testLesson));
    expect(quizState.isQuizComplete, true);
    expect(quizState.isPassed, false);
    // User profile should NOT have completed the lesson
    final profile = container.read(userProfileProvider);
    expect(profile.completedLessonIds.contains('test_threshold_lesson'), false);
  });

  test('Every lesson in every unit has between 7 and 12 questions/steps', () {
    for (final unit in mockUnits) {
      for (final lesson in unit.lessons) {
        expect(
          lesson.questions.length >= 7 && lesson.questions.length <= 12,
          true,
          reason: 'Lesson "${lesson.title}" (${lesson.id}) in "${unit.title}" has ${lesson.questions.length} questions, but must have between 7 and 12.',
        );
      }
    }
  });

  test('TYT Biyoloji unit exists with illustrated diagram questions', () {
    final bioUnit = mockUnits.firstWhere(
      (u) => u.subject == 'TYT Biyoloji',
      orElse: () => throw Exception('TYT Biyoloji unit not found'),
    );

    expect(bioUnit.lessons.isNotEmpty, true);
    final allBioQuestions = bioUnit.lessons.expand((l) => l.questions).toList();
    final diagramQuestions = allBioQuestions.where((q) => q.diagramType != null).toList();
    expect(diagramQuestions.length >= 3, true, reason: 'Must have at least 3 diagram questions in Biyoloji');
  });

  test('Each subject starts at unitNumber 1 and increments sequentially', () {
    final subjects = <String, List<LearningUnit>>{};
    for (final unit in mockUnits) {
      subjects.putIfAbsent(unit.subject, () => []).add(unit);
    }
    for (final entry in subjects.entries) {
      final subjectUnits = entry.value;
      expect(subjectUnits.first.unitNumber, 1, reason: '${entry.key} must start at Unit 1');
      for (int i = 0; i < subjectUnits.length; i++) {
        expect(subjectUnits[i].unitNumber, i + 1, reason: '${entry.key} units must be sequentially numbered');
      }
    }
  });

  test('Matching question validates each pair in real-time: rejects wrong pairs and locks correct pairs', () {
    final matchingLesson = Lesson(
      id: 'test_matching_lesson',
      title: 'Test Matching',
      description: 'Test',
      questions: [
        Question(
          id: 'q_match_1',
          type: QuestionType.matching,
          prompt: 'Kavramları eşleştiriniz.',
          matchingPairs: const [
            MatchingPair(left: 'A', right: '1'),
            MatchingPair(left: 'B', right: '2'),
          ],
        ),
      ],
    );

    final container = ProviderContainer();
    final notifier = container.read(quizProvider(matchingLesson).notifier);

    // 1. Pair incorrectly: A -> 2
    notifier.selectLeft('A');
    notifier.selectRight('2');

    var state = container.read(quizProvider(matchingLesson));
    // Should be rejected: not in matchedPairs, flagged as mismatched, lost 1 heart
    expect(state.matchedPairs.containsKey('A'), false, reason: 'Wrong pair must not be accepted into matchedPairs');
    expect(state.mismatchedLeft, 'A');
    expect(state.mismatchedRight, '2');
    expect(container.read(userProfileProvider).hearts, 4, reason: 'Wrong pair attempt must deduct 1 heart');

    // 2. Pair correctly: A -> 1
    notifier.selectLeft('A');
    notifier.selectRight('1');

    state = container.read(quizProvider(matchingLesson));
    expect(state.matchedPairs['A'], '1', reason: 'Correct pair must be locked into matchedPairs');
    expect(state.isAnswerChecked, false, reason: 'Not all pairs matched yet');

    // 3. Pair remaining correctly: B -> 2
    notifier.selectLeft('B');
    notifier.selectRight('2');

    state = container.read(quizProvider(matchingLesson));
    expect(state.matchedPairs['B'], '2');
    expect(state.isAnswerChecked, true, reason: 'All pairs matched, question should be complete');
    expect(state.isAnswerCorrect, true);
  });

  test('Lesson scores determine completion and locking condition', () {
    final container = ProviderContainer();
    final gameNotifier = container.read(userProfileProvider.notifier);

    final testLesson = Lesson(
      id: 'lesson_tier_test',
      title: 'Tier Test',
      description: 'Test',
      questions: const [],
    );

    // Attempt with 40% (<50% -> not completed, locked)
    gameNotifier.recordLessonAttempt(testLesson, 40.0);
    var profile = container.read(userProfileProvider);
    expect(profile.lessonScores['lesson_tier_test'], 40.0);
    expect(profile.completedLessonIds.contains('lesson_tier_test'), false);

    // Attempt with 80% (>=50% -> completed)
    gameNotifier.recordLessonAttempt(testLesson, 80.0);
    profile = container.read(userProfileProvider);
    expect(profile.lessonScores['lesson_tier_test'], 80.0);
    expect(profile.completedLessonIds.contains('lesson_tier_test'), true);

    // Attempt with 100% (100% -> gold / yellow tier)
    gameNotifier.recordLessonAttempt(testLesson, 100.0);
    profile = container.read(userProfileProvider);
    expect(profile.lessonScores['lesson_tier_test'], 100.0);
    expect(profile.completedLessonIds.contains('lesson_tier_test'), true);
  });

  test('Promo code kagan123 acts as cheat code: sets max hearts and 300 gems', () {
    final container = ProviderContainer();
    final gameNotifier = container.read(userProfileProvider.notifier);

    // Lose some hearts first
    gameNotifier.loseHeart();
    gameNotifier.loseHeart();
    expect(container.read(userProfileProvider).hearts, 3);

    // Apply cheat code kagan123
    final result = gameNotifier.applyPromoCode('kagan123');
    expect(result.success, true);
    expect(result.isCheat, true);

    final profile = container.read(userProfileProvider);
    expect(profile.hearts, profile.maxHearts); // Max hearts: 5
    expect(profile.gems, 300); // 300 gems
  });

  test('Promo code YKS2026 gives discount bonus gems and refills hearts', () {
    final container = ProviderContainer();
    final gameNotifier = container.read(userProfileProvider.notifier);

    gameNotifier.loseHeart();
    final initialGems = container.read(userProfileProvider).gems;

    final result = gameNotifier.applyPromoCode('YKS2026');
    expect(result.success, true);
    expect(result.isCheat, false);

    final profile = container.read(userProfileProvider);
    expect(profile.hearts, profile.maxHearts);
    expect(profile.gems, initialGems + 150);
  });
}

