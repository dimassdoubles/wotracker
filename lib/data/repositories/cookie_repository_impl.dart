import '../models/cookie_model.dart';

import '../../core/errors/exception.dart';
import '../models/record_model.dart';
import '../../domain/entities/cookie.dart';
import '../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/record.dart';
import '../../domain/repositories/cookie_repository.dart';
import '../../domain/usecases/get_today_date.dart';

import '../datasources/cookie_local_data_source.dart';

class CookieRepositoryImpl implements CookieRepository {
  CookieLocalDataSource localDataSource;

  CookieRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> cacheCookie(Cookie cookie) async {
    try {
      localDataSource.cacheCookie(cookie);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Cookie>> getCookie() async {
    try {
      final result = await localDataSource.getCookie();
      // final typeRecords = result.records.runtimeType;
      if (!_isTodayRecordCreated(result.records)) {
        final today = getTodayDate();
        List<Record> newRecords = [RecordModel(today, 0), ...result.records];
        result.records = newRecords;
      }
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  bool _isTodayRecordCreated(List<Record> records) {
    final today = getTodayDate();

    if (records.isEmpty) {
      return false;
    }

    if (records[0].date == today) {
      return true;
    } else {
      return false;
    }
  }
}
