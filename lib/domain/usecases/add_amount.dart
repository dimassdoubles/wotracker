import 'package:dartz/dartz.dart';
import '../../core/errors/exception.dart';
import '../repositories/cookie_repository.dart';

import '../../core/errors/failure.dart';
import '../entities/cookie.dart';

class AddAmount {
  CookieRepository repository;

  AddAmount(this.repository);

  Future<Either<Failure, Cookie>> call(Cookie currentCookie) async {
    currentCookie.records[0].amount += currentCookie.adder;
    // print("today amount baru: ${currentCookie.records[0].amount}");
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
