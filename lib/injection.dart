import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasources/cookie_local_data_source.dart';
import 'data/repositories/cookie_repository_impl.dart';
import 'domain/repositories/cookie_repository.dart';
import 'domain/usecases/add_amount.dart';
import 'domain/usecases/get_cookie.dart';
import 'domain/usecases/set_adder.dart';
import 'presentation/bloc/cookie_bloc.dart';
import 'presentation/cubit/countdown_cubit.dart';

import 'domain/usecases/set_timer.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerLazySingleton(() => CountdownCubit());

  getIt.registerLazySingleton(
    () => CookieBloc(
      getCookie: getIt(),
      setAdder: getIt(),
      setTimer: getIt(),
      addAmount: getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetCookie(
      getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => SetAdder(
      getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => SetTimer(
      getIt(),
    ),
  );
  getIt.registerLazySingleton(
    () => AddAmount(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<CookieRepository>(
    () => CookieRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerLazySingleton<CookieLocalDataSource>(
    () => CookieLocalDataSourceImpl(
      getIt(),
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
}
