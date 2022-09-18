import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wotracker/domain/entities/cookie.dart';
import 'package:wotracker/domain/entities/record.dart';
import 'package:wotracker/domain/repositories/cookie_repository.dart';
import 'package:wotracker/domain/usecases/get_cookie.dart';

class MockCookieRepository extends Mock implements CookieRepository {}

void main() {
  MockCookieRepository mockRepository = MockCookieRepository();
  GetCookie getCookie = GetCookie(mockRepository);

  Cookie testCookie = Cookie(
    timer: 60,
    adder: 10,
    records: [Record("1 September", 50)],
  );

  test(
    "GetCookie should return Cookie",
    () async {
      when(
        () => mockRepository.getCookie(),
      ).thenAnswer(
        (invocation) async => Right(testCookie),
      );

      final result = await mockRepository.getCookie();

      verify(() => mockRepository.getCookie());
      expect(result, Right(testCookie));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
