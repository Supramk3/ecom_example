import 'package:ecom_example_project/src/features/account/account_screen.dart';
import 'package:ecom_example_project/src/features/account/account_screen_controller.dart';
import 'package:ecom_example_project/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group('AccountScreenController', () {
    late MockAuthRepository authRepository;
    setUp(() {
      authRepository = MockAuthRepository();
    });
    test('initial state is AsyncValue.data', () {
      final controller =
          AccountScreenController(authRepository: authRepository);
      expect(controller.debugState, const AsyncValue<void>.data(null));
    });
  });

  test(
    'signOut success',
    () async {
      final authRepository = MockAuthRepository();
      when(() => authRepository.signOut()).thenAnswer(
        (_) => Future.value(),
      );
      final controller =
          AccountScreenController(authRepository: authRepository);

      expect(controller.debugState, const AsyncData<void>(null));
      expectLater(
        controller.stream,
        emitsInOrder(const [
          AsyncLoading<void>(),
          AsyncData<void>(null),
        ]),
      );
      await controller.signOut();
      verify(authRepository.signOut).called(1);
    },
    timeout: const Timeout(Duration(milliseconds: 500)),
  );

  test('signOut failure', () async {
    final authRepository = MockAuthRepository();
    final exception = Exception('Connection failed');
    when(() => authRepository.signOut()).thenThrow(exception);

    final controller = AccountScreenController(authRepository: authRepository);

    await controller.signOut();
    verify(authRepository.signOut).called(1);
    expect(controller.debugState.hasError, true);
  });
}
