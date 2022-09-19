import '../../domain/entities/record.dart';

// ignore: must_be_immutable
class RecordModel extends Record {
  RecordModel(super.date, super.amount);

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      json["date"],
      json["amount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "amount": amount,
    };
  }
}
