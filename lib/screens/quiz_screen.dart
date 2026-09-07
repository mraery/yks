import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lesson_models.dart';
import '../providers/game_provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/concept_card_widget.dart';
import '../widgets/duo_button.dart';
import '../widgets/fill_in_blank_widget.dart';
import '../widgets/matching_game_widget.dart';
import '../widgets/multiple_choice_widget.dart';
import '../widgets/true_false_widget.dart';
import 'lesson_complete_screen.dart';

class QuizScreen extends ConsumerWidget {
  final Lesson lesson;

  const QuizScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider(lesson));
    final quizNotifier = ref.read(quizProvider(lesson).notifier);
    final userProfile = ref.watch(userProfileProvider);

    // Eğer sınav bittiyse tebrik ekranına geçiş
    ref.listen<QuizState>(quizProvider(lesson), (previous, next) {
      if (next.isQuizComplete && !(previous?.isQuizComplete ?? false)) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LessonCompleteScreen(
              lesson: lesson,
              correctCount: next.correctCount,
              totalQuestions: lesson.questions.length,
            ),
          ),
        );
      }
    });

    final currentQuestion = quizState.currentQuestion;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _showExitConfirm(context);
        if (shouldExit == true && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Üst İlerleme ve Can Barı
              _buildTopBar(context, quizState, userProfile.hearts),

              // Soru İçerik Alanı
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: KeyedSubtree(
                    key: ValueKey(currentQuestion.id),
                    child: _buildQuestionContent(
                      currentQuestion,
                      quizState,
                      quizNotifier,
                    ),
                  ),
                ),
              ),

              // Alt Kontrol / Geri Bildirim Barı (Duolingo Stili)
              _buildBottomBar(context, quizState, quizNotifier, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, QuizState state, int hearts) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Çıkış Butonu
          IconButton(
            icon: const Icon(Icons.close_rounded, color: Color(0xFFAFAFAF), size: 28),
            onPressed: () async {
              final shouldExit = await _showExitConfirm(context);
              if (shouldExit == true && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
          const SizedBox(width: 8),

          // İlerleme Çubuğu
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 14,
                child: LinearProgressIndicator(
                  value: state.progress,
                  backgroundColor: const Color(0xFFE5E5E5),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Can Göstergesi
          Row(
            children: [
              const Icon(Icons.favorite_rounded, color: Color(0xFFFF4B4B), size: 26),
              const SizedBox(width: 4),
              Text(
                '$hearts',
                style: const TextStyle(
                  color: Color(0xFFFF4B4B),
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionContent(
    Question question,
    QuizState state,
    QuizNotifier notifier,
  ) {
    switch (question.type) {
      case QuestionType.conceptCard:
        return ConceptCardWidget(question: question);
      case QuestionType.multipleChoice:
        return MultipleChoiceWidget(
          question: question,
          selectedIndex: state.selectedOptionIndex,
          isChecked: state.isAnswerChecked,
          onSelect: notifier.selectOption,
        );
      case QuestionType.matching:
        return MatchingGameWidget(
          question: question,
          matchedPairs: state.matchedPairs,
          selectedLeft: state.selectedLeft,
          selectedRight: state.selectedRight,
          isChecked: state.isAnswerChecked,
          onSelectLeft: notifier.selectLeft,
          onSelectRight: notifier.selectRight,
        );
      case QuestionType.trueFalse:
        return TrueFalseWidget(
          question: question,
          selectedValue: state.selectedBool,
          isChecked: state.isAnswerChecked,
          onSelect: notifier.selectBool,
        );
      case QuestionType.fillInTheBlank:
        return FillInBlankWidget(
          question: question,
          selectedAnswer: state.selectedBlankAnswer,
          isChecked: state.isAnswerChecked,
          onSelect: notifier.selectBlankAnswer,
        );
    }
  }

  Widget _buildBottomBar(
    BuildContext context,
    QuizState state,
    QuizNotifier notifier,
    WidgetRef ref,
  ) {
    // 1. Konu Anlatım Kartı İçin Alt Bar
    if (state.currentQuestion.type == QuestionType.conceptCard) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E5E5), width: 2)),
        ),
        child: DuoButton(
          text: 'ÖĞRENDİM, TEST ET! 🚀',
          color: DuoButtonColor.green,
          height: 52,
          onPressed: notifier.advanceConceptCard,
        ),
      );
    }

    if (!state.isAnswerChecked) {
      // Henüz Kontrol Edilmedi
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E5E5), width: 2)),
        ),
        child: DuoButton(
          text: 'KONTROL ET',
          color: DuoButtonColor.green,
          height: 52,
          onPressed: state.canCheckAnswer ? notifier.checkAnswer : null,
        ),
      );
    }

    // Cevap kontrol edildi (Doğru veya Yanlış Paneli)
    final isCorrect = state.isAnswerCorrect;
    final isGameOver = state.isGameOver;

    final bgColor = isCorrect
        ? const Color(0xFFD7FFB8)
        : const Color(0xFFFFDFE0);
    final primaryColor = isCorrect
        ? const Color(0xFF58CC02)
        : const Color(0xFFFF4B4B);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(top: BorderSide(color: primaryColor.withOpacity(0.3), width: 2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCorrect ? Icons.check_rounded : Icons.close_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                isGameOver
                    ? 'Canların Bitti!'
                    : (isCorrect ? 'Harika!' : 'Doğru Cevap:'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            state.currentQuestion.explanation,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isCorrect ? const Color(0xFF388E3C) : const Color(0xFFD32F2F),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),

          if (isGameOver)
            Row(
              children: [
                Expanded(
                  child: DuoButton(
                    text: 'CAN DOLDUR (50 💎)',
                    color: DuoButtonColor.green,
                    height: 50,
                    onPressed: () {
                      final success = ref
                          .read(userProfileProvider.notifier)
                          .refillHearts(withGems: true);
                      if (success) {
                        notifier.nextQuestion();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DuoButton(
                    text: 'ÇIKIŞ',
                    color: DuoButtonColor.red,
                    height: 50,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            )
          else
            DuoButton(
              text: isCorrect ? 'DEVAM ET' : 'ANLADIM',
              color: isCorrect ? DuoButtonColor.green : DuoButtonColor.red,
              height: 52,
              onPressed: notifier.nextQuestion,
            ),
        ],
      ),
    );
  }

  Future<bool?> _showExitConfirm(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Ayrılmak istiyor musun?',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
          'Şimdi çıkarsan bu dersteki ilerlemen ve kazanacağın puanlar kaydedilmeyecek.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('DEVAM ET', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4B4B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('ÇIK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
