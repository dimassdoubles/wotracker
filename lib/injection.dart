import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wotracker/data/datasources/cookie_local_data_source.dart';
import 'package:wotracker/data/repositories/cookie_repository_impl.dart';
import 'package:wotracker/domain/repositories/cookie_repository.dart';
import 'package:wotracker/domain/usecases/add_amount.dart';
import 'package:wotracker/domain/usecases/get_cookie.dart';
import 'package:wotracker/domain/usecases/set_adder.dart';
import 'package:wotracker/presentation/bloc/cookie_bloc.dart';

import 'core/constants/colors.dart';
import 'domain/usecases/set_timer.dart';

final getIt = GetIt.instance;

Future<void> setup() async {

  getIt.registerFactory(
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
