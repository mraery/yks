import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ykslingo/data/mock_lessons.dart';
import 'package:ykslingo/models/lesson_models.dart';
import 'package:ykslingo/providers/game_provider.dart';
import 'package:ykslingo/providers/quiz_provider.dart';
import 'package:ykslingo/screens/flashcards_screen.dart';

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

  test('Every lesson in every unit has between 8 and 12 questions/steps', () {
    for (final unit in mockUnits) {
      for (final lesson in unit.lessons) {
        expect(
          lesson.questions.length >= 8 && lesson.questions.length <= 12,
          true,
          reason: 'Lesson "${lesson.title}" (${lesson.id}) in "${unit.title}" has ${lesson.questions.length} questions, but must have between 8 and 12.',
        );
      }
    }
  });

  test('TYT Biyoloji unit exists with illustrated diagram questions', () {
    final bioUnits = mockUnits.where((u) => u.subject == 'TYT Biyoloji').toList();
    expect(bioUnits.isNotEmpty, true);
    final allBioQuestions = bioUnits.expand((u) => u.lessons).expand((l) => l.questions).toList();
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

  test('Promo code kagan123 acts as cheat code: sets max hearts and 300 gems, toggles off when re-entered', () {
    final container = ProviderContainer();
    final gameNotifier = container.read(userProfileProvider.notifier);

    // Lose some hearts first
    gameNotifier.loseHeart();
    gameNotifier.loseHeart();
    expect(container.read(userProfileProvider).hearts, 3);

    // Apply cheat code kagan123 (Activate)
    final result = gameNotifier.applyPromoCode('kagan123');
    expect(result.success, true);
    expect(result.isCheat, true);

    var profile = container.read(userProfileProvider);
    expect(profile.hearts, profile.maxHearts); // Max hearts: 5
    expect(profile.gems, 300); // 300 gems
    expect(profile.isCheatUnlocked, true); // Kagan cheat mode enabled

    // Re-enter kagan123 to toggle cheat off
    final toggleResult = gameNotifier.applyPromoCode('kagan123');
    expect(toggleResult.success, true);
    expect(toggleResult.isCheat, false);

    profile = container.read(userProfileProvider);
    expect(profile.isCheatUnlocked, false); // Kagan cheat mode toggled off
  });

  test('Promo code kapat and kagan123 toggle off Premium and return to 5 hearts', () {
    final container = ProviderContainer();
    final gameNotifier = container.read(userProfileProvider.notifier);

    // 1. Activate Premium
    gameNotifier.activatePremium();
    expect(container.read(userProfileProvider).isPremium, true);

    // 2. Enter 'kagan123' to toggle off Premium
    final res1 = gameNotifier.applyPromoCode('kagan123');
    expect(res1.success, true);
    expect(res1.isCheat, false);
    expect(container.read(userProfileProvider).isPremium, false);
    expect(container.read(userProfileProvider).hearts, 5);

    // 3. Re-activate Premium and use 'kapat' code
    gameNotifier.activatePremium();
    expect(container.read(userProfileProvider).isPremium, true);

    final res2 = gameNotifier.applyPromoCode('kapat');
    expect(res2.success, true);
    expect(res2.isCheat, false);
    expect(container.read(userProfileProvider).isPremium, false);
    expect(container.read(userProfileProvider).hearts, 5);

    // 4. Test direct deactivatePremium method
    gameNotifier.activatePremium();
    expect(container.read(userProfileProvider).isPremium, true);
    gameNotifier.deactivatePremium();
    expect(container.read(userProfileProvider).isPremium, false);
    expect(container.read(userProfileProvider).hearts, 5);
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

  test('User with 0 hearts can finish all questions without early kick-out; fails at end if <50% and restarts fresh', () {
    final container = ProviderContainer();
    final gameNotifier = container.read(userProfileProvider.notifier);

    // Empty hearts completely
    for (int i = 0; i < 10; i++) {
      gameNotifier.loseHeart();
    }
    expect(container.read(userProfileProvider).hearts, 0);

    final testLesson = Lesson(
      id: 'lesson_zero_hearts_test',
      title: 'Zero Hearts Test',
      description: 'Test',
      questions: [
        Question(id: 'q1', type: QuestionType.multipleChoice, prompt: 'Soru 1', options: ['A', 'B'], correctIndex: 0),
        Question(id: 'q2', type: QuestionType.multipleChoice, prompt: 'Soru 2', options: ['A', 'B'], correctIndex: 0),
        Question(id: 'q3', type: QuestionType.multipleChoice, prompt: 'Soru 3', options: ['A', 'B'], correctIndex: 0),
      ],
    );

    // First attempt: answer everything wrong
    final notifier = container.read(quizProvider(testLesson).notifier);

    // Q1 wrong: with 0 hearts, it must NOT set isGameOver or kick out
    notifier.selectOption(1);
    notifier.checkAnswer();
    expect(container.read(quizProvider(testLesson)).isGameOver, false);
    expect(container.read(quizProvider(testLesson)).isQuizComplete, false);
    notifier.nextQuestion();

    // Q2 wrong
    expect(container.read(quizProvider(testLesson)).currentIndex, 1);
    notifier.selectOption(1);
    notifier.checkAnswer();
    expect(container.read(quizProvider(testLesson)).isGameOver, false);
    notifier.nextQuestion();

    // Q3 wrong
    expect(container.read(quizProvider(testLesson)).currentIndex, 2);
    notifier.selectOption(1);
    notifier.checkAnswer();
    notifier.nextQuestion();

    // Now quiz completes, accuracy is 0%, isPassed is false, lesson is NOT completed in profile
    final firstAttemptState = container.read(quizProvider(testLesson));
    expect(firstAttemptState.isQuizComplete, true);
    expect(firstAttemptState.accuracy, 0.0);
    expect(firstAttemptState.isPassed, false);
    expect(container.read(userProfileProvider).completedLessonIds.contains('lesson_zero_hearts_test'), false);

    // Now simulate re-entering: create fresh container or recreate provider
    // Since quizProvider is autoDispose, in real app the screen pops and reopens.
    final freshContainer = ProviderContainer();
    final freshState = freshContainer.read(quizProvider(testLesson));

    // Must start from question 0
    expect(freshState.currentIndex, 0);
    expect(freshState.correctCount, 0);
    expect(freshState.isQuizComplete, false);
    expect(freshState.isGameOver, false);
  });

  test('Cheat autoSolveCurrentQuestion automatically marks correct answers without user selecting', () {
    final container = ProviderContainer();
    final customLesson = Lesson(
      id: 'cheat_test_lesson',
      title: 'Cheat Test',
      description: 'Test',
      questions: [
        Question(
          id: 'card_1',
          type: QuestionType.conceptCard,
          conceptTitle: 'Taktik',
          rule: 'Kural',
        ),
        Question(
          id: 'q_mc',
          type: QuestionType.multipleChoice,
          prompt: 'Çoktan seçmeli',
          options: ['Yanlış', 'Doğru'],
          correctIndex: 1,
        ),
        Question(
          id: 'q_tf',
          type: QuestionType.trueFalse,
          prompt: 'Doğru/Yanlış',
          isTrue: true,
        ),
        Question(
          id: 'q_blank',
          type: QuestionType.fillInTheBlank,
          prompt: 'Boşluk doldurma: _____',
          blankOptions: ['elma', 'armut'],
          correctBlankAnswer: 'armut',
        ),
        Question(
          id: 'q_match',
          type: QuestionType.matching,
          prompt: 'Eşleştirme',
          matchingPairs: const [MatchingPair(left: 'A', right: '1')],
        ),
      ],
    );

    final notifier = container.read(quizProvider(customLesson).notifier);

    // 1. Step 0: Concept Card -> autoSolve advances it
    notifier.autoSolveCurrentQuestion();
    expect(container.read(quizProvider(customLesson)).currentIndex, 1);

    // 2. Step 1: Multiple Choice -> autoSolve fills correctIndex: 1 and checks it
    notifier.autoSolveCurrentQuestion();
    var state = container.read(quizProvider(customLesson));
    expect(state.selectedOptionIndex, 1);
    expect(state.isAnswerChecked, true);
    expect(state.isAnswerCorrect, true);
    // Tapping autoSolve again advances to next question
    notifier.autoSolveCurrentQuestion();
    expect(container.read(quizProvider(customLesson)).currentIndex, 2);

    // 3. Step 2: True/False -> autoSolve fills isTrue: true and checks it
    notifier.autoSolveCurrentQuestion();
    state = container.read(quizProvider(customLesson));
    expect(state.selectedBool, true);
    expect(state.isAnswerChecked, true);
    expect(state.isAnswerCorrect, true);
    notifier.autoSolveCurrentQuestion();
    expect(container.read(quizProvider(customLesson)).currentIndex, 3);

    // 4. Step 3: FillInTheBlank -> autoSolve fills 'armut' and checks it
    notifier.autoSolveCurrentQuestion();
    state = container.read(quizProvider(customLesson));
    expect(state.selectedBlankAnswer, 'armut');
    expect(state.isAnswerChecked, true);
    expect(state.isAnswerCorrect, true);
    notifier.autoSolveCurrentQuestion();
    expect(container.read(quizProvider(customLesson)).currentIndex, 4);

    // 5. Step 4: Matching -> autoSolve completes matchingPairs and checks it
    notifier.autoSolveCurrentQuestion();
    state = container.read(quizProvider(customLesson));
    expect(state.matchedPairs['A'], '1');
    expect(state.isAnswerChecked, true);
    expect(state.isAnswerCorrect, true);
    notifier.autoSolveCurrentQuestion();

    // Sınav %100 doğrulukla tamamlandı
    final finalState = container.read(quizProvider(customLesson));
    expect(finalState.isQuizComplete, true);
    expect(finalState.accuracy, 100.0);
    expect(finalState.isPassed, true);
  });

  test('All Biology lessons have concept cards upfront and 8 practice questions following', () {
    final bioUnits = mockUnits.where((u) => u.subject == 'TYT Biyoloji').toList();
    expect(bioUnits.length, 8);

    for (final unit in bioUnits) {
      for (final lesson in unit.lessons) {
        if (lesson.isUnitExam) {
          // Unit exams have 8 pure exam questions
          expect(lesson.questions.length >= 8, true);
          continue;
        }

        // Standard lessons: concept cards must all be at the beginning (before any non-concept questions)
        int firstNonConceptIdx = lesson.questions.indexWhere((q) => q.type != QuestionType.conceptCard);
        expect(firstNonConceptIdx > 0, true, reason: '${lesson.title} should start with concept cards');

        // Verify no concept card appears after the first question
        for (int i = firstNonConceptIdx; i < lesson.questions.length; i++) {
          expect(lesson.questions[i].type != QuestionType.conceptCard, true,
              reason: 'Concept card should not appear in the middle of questions in ${lesson.title}');
        }

        // Verify there are 8 practice questions in the lesson
        final testQuestions = lesson.questions.where((q) => q.type != QuestionType.conceptCard).toList();
        expect(testQuestions.length, 8, reason: '${lesson.title} must have exactly 8 practice questions');
      }
    }
  });

  test('Flashcards deck loads with rich YKS concepts across subjects', () {
    expect(defaultFlashcards.length >= 80, true);
    expect(defaultFlashcards.any((f) => f.subject == 'TYT Biyoloji'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'TYT Matematik'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'TYT Türkçe'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'TYT Tarih'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'TYT Coğrafya'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'TYT Felsefe'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'TYT Din Kültürü'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'AYT Matematik'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'AYT Edebiyat'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'AYT Fizik'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'AYT Kimya'), true);
    expect(defaultFlashcards.any((f) => f.subject == 'AYT Biyoloji'), true);
  });

  test('Comprehensive YKS Curriculum: 79 Units across TYT and AYT', () {
    expect(mockUnits.length, 79);

    final tytUnits = mockUnits.where((u) => !u.subject.startsWith('AYT')).toList();
    final aytUnits = mockUnits.where((u) => u.subject.startsWith('AYT')).toList();

    expect(tytUnits.length, 61);
    expect(aytUnits.length, 18);

    // Total lessons and questions across the entire platform
    final totalLessons = mockUnits.expand((u) => u.lessons).length;
    final totalQuestions = mockUnits.expand((u) => u.lessons).expand((l) => l.questions).length;

    expect(totalLessons >= 240, true, reason: 'Total lessons must exceed 240');
    expect(totalQuestions >= 1600, true, reason: 'Total questions must exceed 1600');
  });

  test('All 2400+ questions across all 79 units have valid answers and formats', () {
    int totalValidated = 0;
    for (final unit in mockUnits) {
      for (final lesson in unit.lessons) {
        for (final q in lesson.questions) {
          totalValidated++;
          switch (q.type) {
            case QuestionType.multipleChoice:
              expect(q.options, isNotNull, reason: 'MC options missing in ${q.id}');
              expect(q.options!.length >= 2, true, reason: 'MC options < 2 in ${q.id}');
              expect(q.correctIndex, isNotNull, reason: 'MC correctIndex missing in ${q.id}');
              expect(q.correctIndex! >= 0 && q.correctIndex! < q.options!.length, true,
                  reason: 'MC correctIndex out of bounds in ${q.id}');
              break;
            case QuestionType.fillInTheBlank:
              expect(q.blankOptions, isNotNull, reason: 'FITB blankOptions missing in ${q.id}');
              expect(q.correctBlankAnswer, isNotNull, reason: 'FITB correctBlankAnswer missing in ${q.id}');
              expect(q.blankOptions!.contains(q.correctBlankAnswer), true,
                  reason: 'FITB correctBlankAnswer "${q.correctBlankAnswer}" not in blankOptions ${q.blankOptions} in ${q.id}');
              break;
            case QuestionType.trueFalse:
              expect(q.isTrue, isNotNull, reason: 'TF isTrue missing in ${q.id}');
              break;
            case QuestionType.matching:
              expect(q.matchingPairs, isNotNull, reason: 'Matching pairs missing in ${q.id}');
              expect(q.matchingPairs!.isNotEmpty, true, reason: 'Matching pairs empty in ${q.id}');
              break;
            case QuestionType.conceptCard:
              expect(q.conceptTitle, isNotNull, reason: 'Concept title missing in ${q.id}');
              expect(q.rule, isNotNull, reason: 'Concept rule missing in ${q.id}');
              expect(q.examTip, isNotNull, reason: 'Concept examTip missing in ${q.id}');
              break;
          }
        }
      }
    }
    expect(totalValidated >= 2400, true);
  });
}



