import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wotracker/domain/entities/cookie.dart';
import 'package:wotracker/domain/entities/record.dart';
import 'package:wotracker/domain/repositories/cookie_repository.dart';
import 'package:wotracker/domain/usecases/add_amount.dart';

class MockCookieRepository extends Mock implements CookieRepository {}

void main() {
  MockCookieRepository repository = MockCookieRepository();
  AddAmount addAmount = AddAmount(repository);

  Cookie testCookie = Cookie(
    timer: 60,
    adder: 10,
    records: [Record('1 September', 15)],
  );

  test(
    'AddAmount should return void when successfully',
    () async {
      when(
        () => repository.cacheCookie(testCookie),
      ).thenAnswer(
        (invocation) async => const Right(null),
      );

      await addAmount(testCookie);
      verify(() => repository.cacheCookie(testCookie));
      verifyNoMoreInteractions(repository);
    },
  );
}
