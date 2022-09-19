import 'package:bloc/bloc.dart';
import 'package:wotracker/domain/usecases/add_amount.dart';
import 'package:wotracker/domain/usecases/get_cookie.dart';
import 'package:wotracker/domain/usecases/set_adder.dart';
import 'package:wotracker/domain/usecases/set_timer.dart';

import 'cookie_event.dart';
import 'cookie_state.dart';

class CookieBloc extends Bloc<CookieEvent, CookieState> {
  GetCookie getCookie;
  SetAdder setAdder;
  SetTimer setTimer;
  AddAmount addAmount;

  CookieBloc({
    required this.getCookie,
    required this.addAmount,
    required this.setAdder,
    required this.setTimer,
  }) : super(InitialState()) {
    on<GetCookieEvent>(
      (event, emit) async {
        final failureOrCookie = await getCookie();
        failureOrCookie.fold(
          (failure) => emit(
            ErrorState("Gagal Memuat Cookie"),
          ),
          (cookie) => emit(
            LoadedState(cookie),
          ),
        );
      },
    );

    on<SetCookieAdderEvent>(
      (event, emit) async {
        final failureOrCookie = await getCookie();
        await failureOrCookie.fold(
          (failure) async {
            emit(
              ErrorState("Gagal Memuat Current Cookie"),
            );
            await Future.delayed(const Duration(seconds: 2));
            emit(state);
          },
          (currentCookie) async {
            final failureOrCookieWhenSetAdder = await setAdder(
                newAdder: event.newAdder, currentCookie: currentCookie);
            failureOrCookieWhenSetAdder.fold(
              (failure) async {
                emit(
                  ErrorState("Gagal Set Adder"),
                );
                await Future.delayed(
                  const Duration(seconds: 2),
                );
                emit(
                  LoadedState(currentCookie),
                );
              },
              (newCookie) => emit(
                LoadedState(newCookie),
              ),
            );
          },
        );
      },
    );

    on<SetCookieTimerEvent>(
      (event, emit) async {
        final failureOrCookie = await getCookie();
        await failureOrCookie.fold(
          (failure) async {
            emit(
              ErrorState("Gagal Memuat Current Cookie"),
            );
            await Future.delayed(const Duration(seconds: 2));
            emit(state);
          },
          (currentCookie) async {
            final failureOrCookieWhenSetTimer = await setTimer(
                newTimer: event.newTimer, currentCookie: currentCookie);
            failureOrCookieWhenSetTimer.fold(
              (failure) async {
                emit(
                  ErrorState("Gagal Set Timer"),
                );
                await Future.delayed(
                  const Duration(seconds: 2),
                );
                emit(
                  LoadedState(currentCookie),
                );
              },
              (newCookie) => emit(
                LoadedState(newCookie),
              ),
            );
          },
        );
      },
    );

    on<AddCookieAmountEvent>(
      (event, emit) async {

        final failureOrCookie = await getCookie();

        await failureOrCookie.fold(
          (failure) async {

            emit(
              ErrorState("Gagal Memuat Current Cookie"),
            );

            await Future.delayed(const Duration(seconds: 2));

            emit(state);
          },
          (currentCookie) async {

            final failureOrCookieWhenAddAmount = await addAmount(currentCookie);

            await failureOrCookieWhenAddAmount.fold(
              (failure) async {

                emit(
                  ErrorState("Gagal Add Amount"),
                );

                await Future.delayed(
                  const Duration(seconds: 2),
                );

                emit(
                  LoadedState(currentCookie),
                );
              },
              (newCookie) async {
                emit(
                  LoadedState(newCookie),
                );
              },
            );
          },
        );
      },
    );
  }
}
