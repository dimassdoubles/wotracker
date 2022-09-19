import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wotracker/core/errors/exception.dart';
import 'package:wotracker/data/datasources/cookie_local_data_source.dart';
import 'package:wotracker/data/models/cookie_model.dart';
import 'package:wotracker/data/models/record_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences sharedPreferences = MockSharedPreferences();
  CookieLocalDataSourceImpl cookieLocalDataSourceImpl =
      CookieLocalDataSourceImpl(sharedPreferences);

  Map<String, dynamic> mapCookie = {
    "timer": 30,
    "adder": 10,
    "records": [
      RecordModel("1 September", 20),
    ]
  };

  CookieModel initialCookieModel = CookieModel(
    timer: 30,
    adder: 10,
    records: const [],
  );

  CookieModel cookieModel = CookieModel.fromJson(mapCookie);

  String stringCookie = jsonEncode(mapCookie);

  test(
    "CookieLocalDataSourceImpl.getCookie should return initialCookieModel when sharedPreferences return null",
    () async {
      when(
        () => sharedPreferences.getString("cookie"),
      ).thenAnswer(
        (invocation) => null,
      );

      final result = await cookieLocalDataSourceImpl.getCookie();
      expect(result, initialCookieModel);
      verify(() => sharedPreferences.getString("cookie"));
    },
  );

  test(
    "CookieLocalDataSourceImpl.getCookie should return CookieModel",
    () async {
      when(
        () => sharedPreferences.getString("cookie"),
      ).thenAnswer(
        (invocation) => stringCookie,
      );

      final result = await cookieLocalDataSourceImpl.getCookie();
      expect(result, cookieModel);
      verify(() => sharedPreferences.getString("cookie"));
    },
  );

  test(
    "CookireLocalDataSource.cache should cache new Cookie",
    () async {
      when(
        () => sharedPreferences.setString("cookie", stringCookie),
      ).thenAnswer(
        (invocation) async => true,
      );

      verify(() => sharedPreferences.setString("cookie", stringCookie));
      verifyNoMoreInteractions(sharedPreferences);
    },
  );

  test(
    "CookireLocalDataSource.cache should throw CacheException when error",
    () async {
      when(
        () => sharedPreferences.setString("cookie", stringCookie),
      ).thenAnswer(
        (invocation) async => false,
      );

      expect(
        () => cookieLocalDataSourceImpl.cacheCookie(cookieModel),
        throwsA(
          isA<CacheException>(),
        ),
      );
      verify(() => sharedPreferences.setString("cookie", stringCookie));
      verifyNoMoreInteractions(sharedPreferences);
    },
  );
}
