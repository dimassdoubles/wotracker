import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wotracker/domain/entities/cookie.dart';
import 'package:wotracker/domain/entities/record.dart';
import 'package:wotracker/domain/repositories/cookie_repository.dart';
import 'package:wotracker/domain/usecases/set_timer.dart';

class MockCookieRepository extends Mock implements CookieRepository {}

void main() {
  MockCookieRepository repository = MockCookieRepository();
  SetTimer setTimer = SetTimer(repository);

  Cookie testCookie = Cookie(
    timer: 60,
    adder: 10,
    records: [Record('1 September', 15)],
  );

  test(
    "SetTimer should return void when successfully",
    () async {
      when(
        () => repository.cacheCookie(testCookie),
      ).thenAnswer(
        (invocation) async => const Right(null),
      );

      await setTimer(
        currentCookie: testCookie,
        newTimer: 32,
      );
      verify(() => repository.cacheCookie(testCookie));
      verifyNoMoreInteractions(repository);
    },
  );
}
