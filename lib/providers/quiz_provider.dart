import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/lesson_models.dart';
import 'game_provider.dart';

class QuizState {
  final Lesson lesson;
  final int currentIndex;
  final int? selectedOptionIndex;
  final bool? selectedBool;
  final String? selectedBlankAnswer; // Boşluk doldurma seçimi
  final Map<String, String> matchedPairs; // Left -> Right matches
  final String? selectedLeft;
  final String? selectedRight;
  final String? mismatchedLeft;
  final String? mismatchedRight;
  final bool isAnswerChecked;
  final bool isAnswerCorrect;
  final int correctCount;
  final bool isQuizComplete;
  final bool isGameOver;

  const QuizState({
    required this.lesson,
    this.currentIndex = 0,
    this.selectedOptionIndex,
    this.selectedBool,
    this.selectedBlankAnswer,
    this.matchedPairs = const {},
    this.selectedLeft,
    this.selectedRight,
    this.mismatchedLeft,
    this.mismatchedRight,
    this.isAnswerChecked = false,
    this.isAnswerCorrect = false,
    this.correctCount = 0,
    this.isQuizComplete = false,
    this.isGameOver = false,
  });

  Question get currentQuestion => lesson.questions[currentIndex];
  double get progress => (currentIndex) / lesson.questions.length;

  int get totalTestQuestions {
    final count = lesson.questions.where((q) => q.type != QuestionType.conceptCard).length;
    return count > 0 ? count : lesson.questions.length;
  }

  double get accuracy {
    final total = totalTestQuestions;
    if (total == 0) return 100.0;
    return (correctCount / total) * 100.0;
  }

  bool get isPassed => accuracy >= 50.0;

  bool get canCheckAnswer {
    if (isAnswerChecked) return false;
    final q = currentQuestion;
    switch (q.type) {
      case QuestionType.conceptCard:
        return true;
      case QuestionType.multipleChoice:
        return selectedOptionIndex != null;
      case QuestionType.trueFalse:
        return selectedBool != null;
      case QuestionType.fillInTheBlank:
        return selectedBlankAnswer != null;
      case QuestionType.matching:
        final totalPairs = q.matchingPairs?.length ?? 0;
        return matchedPairs.length == totalPairs;
    }
  }

  QuizState copyWith({
    Lesson? lesson,
    int? currentIndex,
    int? Function()? selectedOptionIndex,
    bool? Function()? selectedBool,
    String? Function()? selectedBlankAnswer,
    Map<String, String>? matchedPairs,
    String? Function()? selectedLeft,
    String? Function()? selectedRight,
    String? Function()? mismatchedLeft,
    String? Function()? mismatchedRight,
    bool? isAnswerChecked,
    bool? isAnswerCorrect,
    int? correctCount,
    bool? isQuizComplete,
    bool? isGameOver,
  }) {
    return QuizState(
      lesson: lesson ?? this.lesson,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedOptionIndex: selectedOptionIndex != null
          ? selectedOptionIndex()
          : this.selectedOptionIndex,
      selectedBool:
          selectedBool != null ? selectedBool() : this.selectedBool,
      selectedBlankAnswer: selectedBlankAnswer != null
          ? selectedBlankAnswer()
          : this.selectedBlankAnswer,
      matchedPairs: matchedPairs ?? this.matchedPairs,
      selectedLeft:
          selectedLeft != null ? selectedLeft() : this.selectedLeft,
      selectedRight:
          selectedRight != null ? selectedRight() : this.selectedRight,
      mismatchedLeft:
          mismatchedLeft != null ? mismatchedLeft() : this.mismatchedLeft,
      mismatchedRight:
          mismatchedRight != null ? mismatchedRight() : this.mismatchedRight,
      isAnswerChecked: isAnswerChecked ?? this.isAnswerChecked,
      isAnswerCorrect: isAnswerCorrect ?? this.isAnswerCorrect,
      correctCount: correctCount ?? this.correctCount,
      isQuizComplete: isQuizComplete ?? this.isQuizComplete,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }
}

final quizProvider =
    StateNotifierProvider.autoDispose.family<QuizNotifier, QuizState, Lesson>(
        (ref, lesson) {
  return QuizNotifier(ref, lesson);
});

class QuizNotifier extends StateNotifier<QuizState> {
  final Ref _ref;

  QuizNotifier(this._ref, Lesson lesson) : super(QuizState(lesson: lesson));

  void selectOption(int index) {
    if (state.isAnswerChecked) return;
    state = state.copyWith(selectedOptionIndex: () => index);
  }

  void selectBool(bool value) {
    if (state.isAnswerChecked) return;
    state = state.copyWith(selectedBool: () => value);
  }

  void selectBlankAnswer(String? word) {
    if (state.isAnswerChecked) return;
    HapticFeedback.selectionClick();
    state = state.copyWith(selectedBlankAnswer: () => word);
  }

  void selectLeft(String left) {
    if (state.isAnswerChecked) return;
    if (state.matchedPairs.containsKey(left)) return; // Zaten doğru eşleşmişse dokunulamaz

    // Eğer önceki hatalı denemeden kalan kırmızı uyarı varsa hemen temizle
    final hadMismatch = state.mismatchedLeft != null || state.mismatchedRight != null;
    final activeRight = hadMismatch ? null : state.selectedRight;

    if (activeRight != null) {
      _evaluatePair(left, activeRight);
    } else {
      state = state.copyWith(
        selectedLeft: () => left == state.selectedLeft && !hadMismatch ? null : left,
        selectedRight: hadMismatch ? () => null : null,
        mismatchedLeft: () => null,
        mismatchedRight: () => null,
      );
      HapticFeedback.selectionClick();
    }
  }

  void selectRight(String right) {
    if (state.isAnswerChecked) return;
    if (state.matchedPairs.containsValue(right)) return; // Zaten doğru eşleşmişse dokunulamaz

    // Eğer önceki hatalı denemeden kalan kırmızı uyarı varsa hemen temizle
    final hadMismatch = state.mismatchedLeft != null || state.mismatchedRight != null;
    final activeLeft = hadMismatch ? null : state.selectedLeft;

    if (activeLeft != null) {
      _evaluatePair(activeLeft, right);
    } else {
      state = state.copyWith(
        selectedRight: () => right == state.selectedRight && !hadMismatch ? null : right,
        selectedLeft: hadMismatch ? () => null : null,
        mismatchedLeft: () => null,
        mismatchedRight: () => null,
      );
      HapticFeedback.selectionClick();
    }
  }

  void _evaluatePair(String left, String right) {
    final pairs = state.currentQuestion.matchingPairs ?? [];
    final isMatch = pairs.any((p) => p.left == left && p.right == right);

    if (isMatch) {
      // ✅ DOĞRU EŞLEŞME: Yeşil olsun ve kilitlensin
      final newMatched = Map<String, String>.from(state.matchedPairs);
      newMatched[left] = right;
      HapticFeedback.mediumImpact();

      final totalPairs = pairs.length;
      final isAllDone = totalPairs > 0 && newMatched.length == totalPairs;

      state = state.copyWith(
        matchedPairs: newMatched,
        selectedLeft: () => null,
        selectedRight: () => null,
        mismatchedLeft: () => null,
        mismatchedRight: () => null,
        isAnswerChecked: isAllDone,
        isAnswerCorrect: isAllDone,
        correctCount: isAllDone ? state.correctCount + 1 : state.correctCount,
      );
    } else {
      // ❌ YANLIŞ EŞLEŞME: Kırmızı olsun, kabul etmesin, can kaybet
      HapticFeedback.vibrate();
      _ref.read(userProfileProvider.notifier).loseHeart();

      final remainingHearts = _ref.read(userProfileProvider).hearts;
      if (remainingHearts <= 0) {
        final accuracy = state.accuracy;
        _ref.read(userProfileProvider.notifier).recordLessonAttempt(state.lesson, accuracy);
        state = state.copyWith(
          mismatchedLeft: () => left,
          mismatchedRight: () => right,
          isAnswerChecked: true,
          isAnswerCorrect: false,
          isGameOver: true,
        );
        return;
      }

      state = state.copyWith(
        mismatchedLeft: () => left,
        mismatchedRight: () => right,
      );

      // 650ms sonra kırmızıyı ve seçimi temizle ("kabul etmesin")
      Future.delayed(const Duration(milliseconds: 650), () {
        state = state.copyWith(
          mismatchedLeft: () => null,
          mismatchedRight: () => null,
          selectedLeft: () => null,
          selectedRight: () => null,
        );
      });
    }
  }

  void advanceConceptCard() {
    HapticFeedback.lightImpact();
    if (state.currentIndex + 1 >= state.lesson.questions.length) {
      final accuracy = state.accuracy;
      _ref.read(userProfileProvider.notifier).recordLessonAttempt(state.lesson, accuracy);
      state = state.copyWith(
        isQuizComplete: true,
      );
    } else {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        // DİKKAT: Concept card okunduğunda correctCount artmaz! Sadece gerçek sorular sayılır.
        selectedOptionIndex: () => null,
        selectedBool: () => null,
        selectedBlankAnswer: () => null,
        matchedPairs: {},
        selectedLeft: () => null,
        selectedRight: () => null,
        mismatchedLeft: () => null,
        mismatchedRight: () => null,
        isAnswerChecked: false,
        isAnswerCorrect: false,
      );
    }
  }

  void checkAnswer() {
    if (state.isAnswerChecked) return;

    final q = state.currentQuestion;
    if (q.type == QuestionType.conceptCard) {
      advanceConceptCard();
      return;
    }

    bool isCorrect = false;

    switch (q.type) {
      case QuestionType.conceptCard:
        isCorrect = true;
      case QuestionType.multipleChoice:
        isCorrect = state.selectedOptionIndex == q.correctIndex;
      case QuestionType.trueFalse:
        isCorrect = state.selectedBool == q.isTrue;
      case QuestionType.fillInTheBlank:
        isCorrect = state.selectedBlankAnswer == q.correctBlankAnswer;
      case QuestionType.matching:
        final pairs = q.matchingPairs ?? [];
        final totalPairs = pairs.length;
        isCorrect = totalPairs > 0 &&
            state.matchedPairs.length == totalPairs &&
            pairs.every((p) => state.matchedPairs[p.left] == p.right);
    }

    if (!isCorrect) {
      HapticFeedback.vibrate();
      _ref.read(userProfileProvider.notifier).loseHeart();
      final currentHearts = _ref.read(userProfileProvider).hearts;
      if (currentHearts <= 0) {
        final accuracy = state.accuracy;
        _ref.read(userProfileProvider.notifier).recordLessonAttempt(state.lesson, accuracy);
        state = state.copyWith(
          isAnswerChecked: true,
          isAnswerCorrect: false,
          isGameOver: true,
        );
        return;
      }
    } else {
      HapticFeedback.lightImpact();
    }

    state = state.copyWith(
      isAnswerChecked: true,
      isAnswerCorrect: isCorrect,
      correctCount: isCorrect ? state.correctCount + 1 : state.correctCount,
    );
  }

  void nextQuestion() {
    if (state.currentIndex + 1 >= state.lesson.questions.length) {
      // Sınav tamamlandı - Gerçek soru başarı oranı ile kaydet
      final accuracy = state.accuracy;
      _ref.read(userProfileProvider.notifier).recordLessonAttempt(state.lesson, accuracy);
      state = state.copyWith(isQuizComplete: true);
    } else {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        selectedOptionIndex: () => null,
        selectedBool: () => null,
        selectedBlankAnswer: () => null,
        matchedPairs: {},
        selectedLeft: () => null,
        selectedRight: () => null,
        mismatchedLeft: () => null,
        mismatchedRight: () => null,
        isAnswerChecked: false,
        isAnswerCorrect: false,
      );
    }
  }
}
