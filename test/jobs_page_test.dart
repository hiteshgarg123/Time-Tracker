import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home/jobs/empty_page_content.dart';
import 'package:time_tracker/app/home/jobs/jobs_page.dart';
import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/services/database.dart';

import 'mocks.dart';

void main() {
  MockDatabase mockAuth;
  StreamController<List<Job>> jobsStreamController;

  setUp(() {
    mockAuth = MockDatabase();
    jobsStreamController = StreamController<List<Job>>();
  });
  tearDown(() {
    jobsStreamController.close();
  });

  Future<void> pumpJobsPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<Database>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: JobsPage(),
        ),
      ),
    );
    await tester.pump();
  }

  void stubOnJobsChange(Iterable<List<Job>> onJobsChange) {
    jobsStreamController
        .addStream(Stream<List<Job>>.fromIterable(onJobsChange));
    when(mockAuth.jobsStream()).thenAnswer((_) => jobsStreamController.stream);
  }

  testWidgets('stream waiting', (WidgetTester tester) async {
    stubOnJobsChange([]);
    await pumpJobsPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('no jobs', (WidgetTester tester) async {
    stubOnJobsChange([<Job>[]]);
    await pumpJobsPage(tester);

    expect(find.byType(EmptyPageContent), findsOneWidget);
  });

  testWidgets('some jobs', (WidgetTester tester) async {
    stubOnJobsChange([
      [
        Job(
          id: 'abc',
          name: 'Test',
          ratePerHour: 10,
        )
      ]
    ]);
    await pumpJobsPage(tester);

    expect(find.byType(ListView), findsOneWidget);
  });
}
