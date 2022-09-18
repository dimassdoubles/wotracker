import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wotracker/domain/entities/cookie.dart';
import 'package:wotracker/domain/entities/record.dart';
import 'package:wotracker/domain/usecases/add_amount.dart';
import 'package:wotracker/domain/usecases/get_cookie.dart';
import 'package:wotracker/domain/usecases/get_today_date.dart';
import 'package:wotracker/domain/usecases/set_adder.dart';
import 'package:wotracker/domain/usecases/set_timer.dart';
import 'package:wotracker/presentation/bloc/cookie_bloc.dart';
import 'package:wotracker/presentation/bloc/cookie_event.dart';
import 'package:wotracker/presentation/bloc/cookie_state.dart';

class MockGetCookie extends Mock implements GetCookie {}

class MockAddAmount extends Mock implements AddAmount {}

class MockSetAdder extends Mock implements SetAdder {}

class MockSetTimer extends Mock implements SetTimer {}

void main() {
  final getCookie = MockGetCookie();
  final addAmount = MockAddAmount();
  final setAdder = MockSetAdder();
  final setTimer = MockSetTimer();

  final cookieBloc = CookieBloc(
    getCookie: getCookie,
    addAmount: addAmount,
    setAdder: setAdder,
    setTimer: setTimer,
  );

  Cookie testCookie =
      Cookie(adder: 10, timer: 60, records: [Record(getTodayDate(), 10)]);

  blocTest<CookieBloc, CookieState>(
    "emit [LoadedState(testCookie)] When GetCookieEvent added",
    build: () => cookieBloc,
    setUp: () {
      when(
        () => getCookie(),
      ).thenAnswer(
        (invocation) async => Right(testCookie),
      );
    },
    act: (bloc) => bloc.add(
      GetCookieEvent(),
    ),
    expect: () => [
      LoadedState(testCookie),
    ],
  );

  final expectedCookie = Cookie(
    adder: 10,
    timer: 60,
    records: [Record(getTodayDate(), 10 + 10)],
  );
  blocTest(
    "Emit [LoadedState(newCookie)] when AddAmountEvent added",
    build: () => cookieBloc,
    setUp: () {
      when(
        () => getCookie(),
      ).thenAnswer(
        (invocation) async => Right(testCookie),
      );

      when(() => addAmount(testCookie)).thenAnswer(
        (invocation) async => Right(expectedCookie),
      );
    },
    act: (bloc) => bloc.add(
      AddCookieAmountEvent(),
    ),
    expect: () => [
      LoadedState(expectedCookie),
    ],
  );
}
