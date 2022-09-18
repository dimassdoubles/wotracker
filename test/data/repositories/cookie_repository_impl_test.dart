import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wotracker/data/datasources/cookie_local_data_source.dart';
import 'package:wotracker/data/models/cookie_model.dart';
import 'package:wotracker/data/models/record_model.dart';
import 'package:wotracker/data/repositories/cookie_repository_impl.dart';
import 'package:wotracker/domain/usecases/get_today_date.dart';

class MockCookieLocalDataSource extends Mock implements CookieLocalDataSource {}

void main() {
  MockCookieLocalDataSource localDataSource = MockCookieLocalDataSource();
  CookieRepositoryImpl cookieRepositoryImpl =
      CookieRepositoryImpl(localDataSource);

  String today = getTodayDate();
  List<RecordModel> records = [
    RecordModel("1 September", 12),
  ];

  List<RecordModel> expectedRecords = [
    RecordModel(today, 0),
    RecordModel("1 September", 12),
  ];

  CookieModel testCookieModel = CookieModel(
    timer: 60,
    adder: 10,
    records: records,
  );

  CookieModel expectedCookiModel = CookieModel(
    timer: 60,
    adder: 10,
    records: expectedRecords,
  );

  test(
    "CookieRepositoryImpl.getCookie should make RecordModel when today record not made",
    () async {
      when(
        () => localDataSource.getCookie(),
      ).thenAnswer(
        (invocation) async => testCookieModel,
      );

      final result = await cookieRepositoryImpl.getCookie();
      verify(() => localDataSource.getCookie());
      expect(result, Right(expectedCookiModel));
      verifyNoMoreInteractions(localDataSource);
    },
  );

  test(
    "CookieRepositoryImpl.getRecord shouldn't make RecordModel for today when Records[0].date == today",
    () async {
      when(
        () => localDataSource.getCookie(),
      ).thenAnswer(
        (invocation) async => expectedCookiModel,
      );

      final result = await cookieRepositoryImpl.getCookie();
      verify(() => localDataSource.getCookie());
      expect(result, Right(expectedCookiModel));
      verifyNoMoreInteractions(localDataSource);
    },
  );
}
