
import 'package:flutter_test/flutter_test.dart';
import 'package:wotracker/data/models/cookie_model.dart';
import 'package:wotracker/domain/entities/record.dart';

void main() {
  Map<String, dynamic> testMapCookieModel = {
    "timer": 60,
    "adder": 10,
    "records": [
      Record("1 September", 20),
    ],
  };

  CookieModel testCookieModel = CookieModel(
    timer: 60,
    adder: 10,
    records: [
      Record("1 September", 20),
    ],
  );

  test(
    "CookieModel.fromJson should return Record",
    () {
      final result = CookieModel.fromJson(testMapCookieModel);
      expect(result, testCookieModel);
    },
  );

  test(
    "CookieModel.toJson should return Map<String, dynamic>",
    () {
      final result = testCookieModel.toJson();
      expect(result, testMapCookieModel);
    },
  );
}
