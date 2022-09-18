import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wotracker/core/errors/failure.dart';
import 'package:wotracker/domain/entities/cookie.dart';
import 'package:wotracker/domain/entities/record.dart';
import 'package:wotracker/domain/repositories/cookie_repository.dart';
import 'package:wotracker/domain/usecases/set_adder.dart';

class MockCookieRepository extends Mock implements CookieRepository {}

void main() {
  MockCookieRepository repository = MockCookieRepository();
  SetAdder setAdder = SetAdder(repository);

  Cookie testCookie = Cookie(
    timer: 60,
    adder: 10,
    records: [Record('1 September', 15)],
  );

  Cookie expectedCookie = Cookie(
    timer: 60,
    adder: 23,
    records: [Record('1 September', 15)],
  );

  test(
    "SetAdder should return new Cookie when successfully",
    () async {
      when(
        () => repository.cacheCookie(testCookie),
      ).thenAnswer(
        (invocation) async => const Right(null),
      );

      final result = await setAdder(
        currentCookie: testCookie,
        newAdder: 23,
      );

      expect(result, Right(expectedCookie));
      verify(() => repository.cacheCookie(testCookie));
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    "SetAdder should return CacheFailure when unsuccessfully",
    () async {
      when(
        () => repository.cacheCookie(testCookie),
      ).thenAnswer(
        (invocation) async => Left(CacheFailure()),
      );

      final result = await setAdder(
        currentCookie: testCookie,
        newAdder: 23,
      );

      expect(result, Left(CacheFailure()));
      verify(() => repository.cacheCookie(testCookie));
      verifyNoMoreInteractions(repository);
    },
  );
}
