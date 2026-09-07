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
    this.isAnswerChecked = false,
    this.isAnswerCorrect = false,
    this.correctCount = 0,
    this.isQuizComplete = false,
    this.isGameOver = false,
  });

  Question get currentQuestion => lesson.questions[currentIndex];
  double get progress => (currentIndex) / lesson.questions.length;

  bool get isPassed {
    final total = lesson.questions.length;
    if (total == 0) return true;
    return ((correctCount / total) * 100) >= 50.0;
  }

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

    // Eğer sol kart zaten eşleştirilmişse, dokunulduğunda eşleşmeyi kaldır (unpair)
    if (state.matchedPairs.containsKey(left)) {
      final newMatched = Map<String, String>.from(state.matchedPairs)..remove(left);
      state = state.copyWith(
        matchedPairs: newMatched,
        selectedLeft: () => null,
      );
      HapticFeedback.selectionClick();
      return;
    }

    if (state.selectedRight != null) {
      _pair(left, state.selectedRight!);
    } else {
      state = state.copyWith(
        selectedLeft: () => left == state.selectedLeft ? null : left,
      );
      HapticFeedback.selectionClick();
    }
  }

  void selectRight(String right) {
    if (state.isAnswerChecked) return;

    // Eğer sağ kart zaten eşleştirilmişse, dokunulduğunda eşleşmeyi kaldır (unpair)
    if (state.matchedPairs.containsValue(right)) {
      final newMatched = Map<String, String>.from(state.matchedPairs);
      newMatched.removeWhere((k, v) => v == right);
      state = state.copyWith(
        matchedPairs: newMatched,
        selectedRight: () => null,
      );
      HapticFeedback.selectionClick();
      return;
    }

    if (state.selectedLeft != null) {
      _pair(state.selectedLeft!, right);
    } else {
      state = state.copyWith(
        selectedRight: () => right == state.selectedRight ? null : right,
      );
      HapticFeedback.selectionClick();
    }
  }

  void _pair(String left, String right) {
    final newMatched = Map<String, String>.from(state.matchedPairs);
    newMatched.remove(left);
    newMatched.removeWhere((k, v) => v == right);
    newMatched[left] = right;
    HapticFeedback.lightImpact();
    state = state.copyWith(
      matchedPairs: newMatched,
      selectedLeft: () => null,
      selectedRight: () => null,
    );
  }

  void advanceConceptCard() {
    HapticFeedback.lightImpact();
    if (state.currentIndex + 1 >= state.lesson.questions.length) {
      final finalCorrect = state.correctCount + 1;
      final accuracy = (finalCorrect / state.lesson.questions.length) * 100;
      _ref.read(userProfileProvider.notifier).recordLessonAttempt(state.lesson, accuracy);
      state = state.copyWith(
        isQuizComplete: true,
        correctCount: finalCorrect,
      );
    } else {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        correctCount: state.correctCount + 1,
        selectedOptionIndex: () => null,
        selectedBool: () => null,
        selectedBlankAnswer: () => null,
        matchedPairs: {},
        selectedLeft: () => null,
        selectedRight: () => null,
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
      // Sınav tamamlandı - Skor ve en az %50 başarı kontrolü
      final accuracy = (state.correctCount / state.lesson.questions.length) * 100;
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
        isAnswerChecked: false,
        isAnswerCorrect: false,
      );
    }
  }
}
