import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker/app/home/models/job.dart';

void main() {
  group('fromMap', () {
    test('null test', () {
      final job = Job.fromMap(null, 'abc');
      expect(job, null);
    });
    test('job with all properties', () {
      final job = Job.fromMap({
        'name': 'Blogging',
        'ratePerHour': 20,
      }, 'abc');
      expect(
        job,
        Job(id: 'abc', name: 'Blogging', ratePerHour: 20),
      );
    });
    test('job with missing name', () {
      final job = Job.fromMap({
        'ratePerHour': 20,
      }, 'abc');
      expect(job, null);
    });
  });

  group('toMap', () {
    test('valid name , ratePerHour', () {
      final job = Job(name: 'Production', ratePerHour: 30, id: 'xyz');
      expect(job.toMap(), {
        'name': 'Production',
        'ratePerHour': 30,
      });
    });
  });
}
