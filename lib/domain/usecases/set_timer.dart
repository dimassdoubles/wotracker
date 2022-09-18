import 'package:dartz/dartz.dart';
import '../../core/errors/exception.dart';
import '../../core/errors/failure.dart';
import '../repositories/cookie_repository.dart';

import '../entities/cookie.dart';

class SetTimer {
  CookieRepository repository;

  SetTimer(this.repository);

  Future<Either<Failure, Cookie>> call(
      {required Cookie currentCookie, required int newTimer}) async {
    currentCookie.timer = newTimer;
    // print("timer baru: ${currentCookie.timer}");
    try {
      final result = await repository.cacheCookie(currentCookie);
      if (result == Right(null)) {
        return Right(currentCookie);
      } else {
        throw CacheException();
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
