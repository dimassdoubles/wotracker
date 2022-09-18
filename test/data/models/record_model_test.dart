import 'package:flutter_test/flutter_test.dart';
import 'package:wotracker/data/models/record_model.dart';

void main() {
  Map<String, dynamic> testMapRecordModel = {
    "date": "1 September",
    "amount": 10,
  };

  RecordModel testRecordModel = RecordModel("1 September", 10);

  test(
    "RecordModel.fromJson should return RecordModel",
    () {
      final result = RecordModel.fromJson(testMapRecordModel);
      expect(result, testRecordModel);
    },
  );

  test(
    "RecordModel.toJson should return Map<String, dynamic>",
    () {
      final result = testRecordModel.toJson();
      expect(result, testMapRecordModel);
    },
  );
}
