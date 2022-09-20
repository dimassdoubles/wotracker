import 'package:dartz/dartz.dart';
import '../../core/errors/exception.dart';
import '../../core/errors/failure.dart';
import '../entities/cookie.dart';
import '../repositories/cookie_repository.dart';

class SetAdder {
  CookieRepository repository;

  SetAdder(this.repository);

  Future<Either<Failure, Cookie>> call(
      {required Cookie currentCookie, required int newAdder}) async {
    currentCookie.adder = newAdder;
    try {
      final result = await repository.cacheCookie(currentCookie);
      // ignore: unrelated_type_equality_checks
      if (result == const Right(null)) {
        return Right(currentCookie);
      } else {
        throw CacheException();
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
