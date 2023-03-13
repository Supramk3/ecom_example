import 'package:ecom_example_project/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecom_example_project/src/models/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testEmail = 'test@gmail.com';
  const testPassword = '1234';
  final testUser =
      AppUser(uid: testEmail.split('').reversed.join(), email: testEmail);

  FakeAuthRepository makeAuthRepository() =>
      FakeAuthRepository(addDelay: false);
  group('FakeAuthRepository', () {
    test('currentUser is null', () {
      final authRepository = FakeAuthRepository();
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });

    // test('currentUser is not null after sign in', () async {
    //   final authRepository = makeAuthRepository();
    //   await authRepository.signInWithEmailAndPassoword(testEmail, testPassword);
    //   expect(authRepository.currentUser, testUser);
    //   expect(authRepository.authStateChanges(), emits(testUser));
    // });
    // test('currentUser is not null after  registration', () async {
    //   final authRepository = makeAuthRepository();
    //   await authRepository.createUserWithEmailAndPassword(
    //       testEmail, testPassword);
    //   expect(authRepository.currentUser, testUser);
    //   expect(authRepository.authStateChanges(), emits(testUser));
    // });

    test('currentUser is null after sign out', () async {
      final authRepository = makeAuthRepository();
      await authRepository.signInWithEmailAndPassoword(testEmail, testPassword);
      await authRepository.signOut();
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });
  });
}
