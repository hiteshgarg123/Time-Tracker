import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';

import 'mocks.dart';

void main() {
  MockAuth mockAuth;
  MockNavigatorObsserver mockNavigatorObsserver;

  setUp(() {
    mockAuth = MockAuth();
    mockNavigatorObsserver = MockNavigatorObsserver();
  });

  Future<void> pumpSignInPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Builder(
            builder: (context) => SignInPage.create(context),
          ),
          navigatorObservers: [mockNavigatorObsserver],
        ),
      ),
    );
    verify(mockNavigatorObsserver.didPush(any, any)).called(1);
  }

  testWidgets('email & password navigation', (WidgetTester tester) async {
    await pumpSignInPage(tester);

    final emailSignInButton = find.byKey(SignInPage.emailPasswordKey);
    expect(emailSignInButton, findsOneWidget);

    await tester.tap(emailSignInButton);
    await tester.pumpAndSettle();

    verify(mockNavigatorObsserver.didPush(any, any)).called(1);
  });
}
