import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ykslingo/models/lesson_models.dart';
import 'package:ykslingo/providers/game_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Game provider initial values and heart loss', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // Initial state
    var profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(5));
    expect(profile.maxHearts, equals(5));
    expect(profile.xp, equals(0));

    // Lose a heart
    container.read(userProfileProvider.notifier).loseHeart();
    profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(4));

    // Complete lesson gives XP and Gems
    const dummyLesson = Lesson(
      id: 'test_lesson',
      title: 'Test',
      description: 'Test Desc',
      xpReward: 30,
      gemReward: 15,
      questions: [],
    );

    container.read(userProfileProvider.notifier).completeLesson(dummyLesson);
    profile = container.read(userProfileProvider);

    expect(profile.xp, equals(30));
    expect(profile.gems, equals(115)); // 100 + 15
    expect(profile.streak, equals(1));
    expect(profile.completedLessonIds.contains('test_lesson'), isTrue);
  });

  test('Heart depletion, 50-gem refill, and unlimited hearts with Premium', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(userProfileProvider.notifier);
    var profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(5));
    expect(profile.gems, equals(100));
    expect(profile.isPremium, isFalse);

    // Yanlış cevaplar ile 5 canın tamamının kaybedilmesi
    for (int i = 0; i < 5; i++) {
      notifier.loseHeart();
    }
    profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(0), reason: '5 yanlış cevap sonrası can 0 olmalı');

    // Can 0 iken daha fazla düşmemeli
    notifier.loseHeart();
    profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(0));

    // 50 Elmas ile canları tamamen yenileme (5 Can)
    final refillSuccess = notifier.refillHearts(withGems: true);
    expect(refillSuccess, isTrue);
    profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(5), reason: 'Canlar 50 elmas ile 5/5 olmalı');
    expect(profile.gems, equals(50), reason: '100 elmastan 50 düşülmeli');

    // Tekrar 5 can kaybetme
    for (int i = 0; i < 5; i++) {
      notifier.loseHeart();
    }
    profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(0));

    // Premium Satın Alma / Aktif Etme
    notifier.activatePremium();
    profile = container.read(userProfileProvider);
    expect(profile.isPremium, isTrue);
    expect(profile.hearts, equals(5));

    // Premium iken yanlış cevap verilse bile can eksilmemeli (Sınırsız Can)
    notifier.loseHeart();
    notifier.loseHeart();
    profile = container.read(userProfileProvider);
    expect(profile.hearts, equals(5), reason: 'Premium üyede sınırsız can olmalı');
  });
}
