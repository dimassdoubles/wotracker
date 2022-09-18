import 'package:flutter_test/flutter_test.dart';
import 'package:wotracker/core/utils/date_formatter.dart';
import 'package:wotracker/domain/usecases/get_today_date.dart';

void main() {
  DateTime today = DateTime.now();
  String expectedResult = dateFormatter(today);

  test(
    'GetTodayDate should return today {day month}',
    () {
      final result = getTodayDate();
      expect(result, expectedResult);
    },
  );
}
