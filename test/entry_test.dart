import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/app/home/models/entry.dart';

void main() {
  group('durationIn Hours', () {
    test('positive', () {
      final entry = Entry(
        id: 'abc',
        jobId: 'xyz',
        start: DateTime(2020, 07, 15, 5, 40),
        end: DateTime(2020, 07, 15, 6, 40),
      );
      expect(entry.durationInHours, 1.0);
    });
    test('negative', () {
      final entry = Entry(
        id: 'abc',
        jobId: 'xyz',
        start: DateTime(2020, 07, 15, 5, 40),
        end: DateTime(2020, 07, 15, 4, 40),
      );
      expect(entry.durationInHours, -1.0);
    });
    test('zero', () {
      final entry = Entry(
        id: 'abc',
        jobId: 'xyz',
        start: DateTime(2020, 07, 15, 5, 40),
        end: DateTime(2020, 07, 15, 5, 40),
      );
      expect(entry.durationInHours, 0.0);
    });
  });

  group('fromMap', () {
    test('null test', () {
      final entry = Entry.fromMap(null, 'abc');
      expect(entry, null);
    });

    test('entry with all properties', () {
      final entry = Entry.fromMap({
        'jobId': 'xyz',
        'start': DateTime(2020, 07, 15, 5, 40).millisecondsSinceEpoch,
        'end': DateTime(2020, 07, 15, 6, 40).millisecondsSinceEpoch,
        'comment': 'New entry',
      }, 'abc');
      expect(
        entry,
        Entry(
          id: 'abc',
          jobId: 'xyz',
          start: DateTime(2020, 07, 15, 5, 40),
          end: DateTime(2020, 07, 15, 6, 40),
          comment: 'New entry',
        ),
      );
    });
  });
  group('toMap', () {
    test('valid properties', () {
      final entry = Entry(
        id: 'abc',
        jobId: 'xyz',
        start: DateTime(2020, 07, 15, 5, 40),
        end: DateTime(2020, 07, 15, 6, 40),
        comment: 'New entry',
      );
      expect(entry.toMap(), {
        'jobId': 'xyz',
        'start': DateTime(2020, 07, 15, 5, 40).millisecondsSinceEpoch,
        'end': DateTime(2020, 07, 15, 6, 40).millisecondsSinceEpoch,
        'comment': 'New entry'
      });
    });
  });
}
