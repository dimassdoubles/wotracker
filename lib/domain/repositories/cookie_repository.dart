import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/cookie.dart';

abstract class CookieRepository {
  Future<Either<Failure, Cookie>> getCookie();
  Future<Either<Failure, void>> cacheCookie(Cookie cookie);
}
