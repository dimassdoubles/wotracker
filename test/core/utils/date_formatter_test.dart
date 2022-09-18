import 'package:flutter_test/flutter_test.dart';
import 'package:wotracker/core/utils/date_formatter.dart';

void main() {
  DateTime today = DateTime(
    2022,
    1,
    1,
  );
  String expectedResult = "1 Januari";

  test(
    "dateFormatter should return {day month}",
    () {
      final result = dateFormatter(today);
      expect(result, expectedResult);
    },
  );
}
