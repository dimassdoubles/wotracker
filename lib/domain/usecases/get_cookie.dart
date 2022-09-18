import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../entities/cookie.dart';
import '../repositories/cookie_repository.dart';

class GetCookie {
  CookieRepository repository;

  GetCookie(this.repository);

  Future<Either<Failure, Cookie>> call() async {
    return await repository.getCookie();
  }
}
