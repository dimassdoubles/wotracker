import '../../domain/entities/cookie.dart';

class CookieModel extends Cookie {
  CookieModel(
      {required super.timer, required super.adder, required super.records});

  factory CookieModel.fromJson(Map<String, dynamic> json) {
    return CookieModel(
      timer: json["timer"],
      adder: json["adder"],
      records: json["records"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "timer": timer,
      "adder": adder,
      "records": records,
    };
  }
}
