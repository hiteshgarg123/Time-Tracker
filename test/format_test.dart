import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker/app/home/job_entries/format.dart';

void main() {
  group('hours', () {
    test('positive', () {
      expect(Format.hours(10), '10h');
    });
    test('zero', () {
      expect(Format.hours(0), '0h');
    });
    test('negative', () {
      expect(Format.hours(-17), '0h');
    });
    test('decimal', () {
      expect(Format.hours(7.9), '7.9h');
    });
  });

  group('date - GB Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2020-07-15', () {
      expect(
        Format.date(DateTime(2020, 07, 15)),
        '15 Jul 2020',
      );
    });
    test('2020-09-28', () {
      expect(
        Format.date(DateTime(2020, 09, 28)),
        '28 Sep 2020',
      );
    });
  });
  group('dayofweek - GB Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Wednesday', () {
      expect(
        Format.dayOfWeek(DateTime(2020, 07, 15)),
        'Wed',
      );
    });
  });
  group('dayofweek - IT Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'it_IT';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('Mercoledi', () {
      expect(
        Format.dayOfWeek(DateTime(2020, 07, 15)),
        'mer',
      );
    });
  });

  group('currency - US Locale', () {
    setUp(() {
      Intl.defaultLocale = 'en_US';
    });
    test('positive', () {
      expect(Format.currency(10), '\$10');
    });
    test('zero', () {
      expect(Format.currency(0), '');
    });
    test('negative', () {
      expect(Format.currency(-17), '-\$17');
    });
  });
}
