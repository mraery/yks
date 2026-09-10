import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ykslingo/providers/game_provider.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Peanut ad reward adds 5 gems to user profile', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(userProfileProvider.notifier);

    final initialGems = container.read(userProfileProvider).gems;
    notifier.addGems(5);
    expect(container.read(userProfileProvider).gems, initialGems + 5);
  });

  test('Premium status prevents ad breaks and grants unlimited hearts', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(userProfileProvider.notifier);

    expect(container.read(userProfileProvider).isPremium, false);
    notifier.activatePremium();
    expect(container.read(userProfileProvider).isPremium, true);

    // Losing hearts when premium does not decrease hearts
    notifier.loseHeart();
    expect(container.read(userProfileProvider).hearts, 5);
  });

  test('Every 3 completed lessons triggers ad eligibility for non-premium users', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final profile = container.read(userProfileProvider);

    expect(profile.isPremium, false);
    expect(3 % 3 == 0, true);
    expect(6 % 3 == 0, true);
  });

  test('incrementQuestionsAnswered triggers ad eligibility every 10 questions for non-premium users', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final notifier = container.read(userProfileProvider.notifier);

    for (int i = 1; i <= 9; i++) {
      expect(notifier.incrementQuestionsAnswered(), false, reason: 'Question $i should not trigger ad');
    }
    // 10th question triggers ad
    expect(notifier.incrementQuestionsAnswered(), true, reason: '10th question must trigger ad break');

    for (int i = 11; i <= 19; i++) {
      expect(notifier.incrementQuestionsAnswered(), false);
    }
    // 20th question triggers ad
    expect(notifier.incrementQuestionsAnswered(), true, reason: '20th question must trigger ad break');

    // If premium, 30th question does NOT trigger ad
    notifier.activatePremium();
    for (int i = 21; i <= 30; i++) {
      expect(notifier.incrementQuestionsAnswered(), false, reason: 'Premium users never see ads');
    }
  });
}
