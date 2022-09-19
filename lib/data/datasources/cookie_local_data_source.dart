import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../core/errors/exception.dart';
import '../models/record_model.dart';

import '../../domain/entities/cookie.dart';
import '../models/cookie_model.dart';

abstract class CookieLocalDataSource {
  Future<CookieModel> getCookie();
  Future<void> cacheCookie(Cookie cookie);
}

class CookieLocalDataSourceImpl implements CookieLocalDataSource {
  SharedPreferences sharedPreferences;

  CookieLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheCookie(Cookie cookie) async {
    CookieModel cookieModel = CookieModel(
      adder: cookie.adder,
      timer: cookie.timer,
      records: cookie.records,
    );

    String stringCookie = jsonEncode(cookieModel.toJson());
    final success = await sharedPreferences.setString("cookie", stringCookie);

    if (!success) {
      throw CacheException();
    }
  }

  @override
  Future<CookieModel> getCookie() async {
    final String? cookieString = sharedPreferences.getString('cookie');

    if (cookieString != null) {
      Map<String, dynamic> response = jsonDecode(cookieString);

      // List<Map<String, dynamic>> recordsJson = response["records"];
      // List<RecordModel> records = response["records"]
      //     .map(
      //       (e) => RecordModel.fromJson(e),
      //     )
      //     .toList();

      List<RecordModel> records = [];

      for (int i = 0; i < response["records"].length; i++) {
        records.add(RecordModel.fromJson(response["records"][i]));
      }

      response["records"] = records;

      return CookieModel.fromJson(response);
    } else {
      CookieModel initialCookieModel = CookieModel(
        timer: 30,
        adder: 10,
        records: const [],
      );
      return initialCookieModel;
    }
  }
}
