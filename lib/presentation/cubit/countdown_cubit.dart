import 'package:bloc/bloc.dart';

class CountdownCubit extends Cubit<int> {
  int timer = 0;
  CountdownCubit() : super(0);

  void setTimer(int timer) {
    this.timer = timer;
    emit(timer);
  }

  void setCountDown(int countdown) {
    emit(countdown);
  }
}
