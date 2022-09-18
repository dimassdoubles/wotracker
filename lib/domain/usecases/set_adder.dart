import 'package:dartz/dartz.dart';
import 'package:wotracker/core/errors/exception.dart';
import '../../core/errors/failure.dart';
import '../entities/cookie.dart';
import '../repositories/cookie_repository.dart';

class SetAdder {
  CookieRepository repository;

  SetAdder(this.repository);

  Future<Either<Failure, Cookie>> call(
      {required Cookie currentCookie, required int newAdder}) async {
    currentCookie.adder = newAdder;
    // print("adder baru :${currentCookie.adder}");
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
