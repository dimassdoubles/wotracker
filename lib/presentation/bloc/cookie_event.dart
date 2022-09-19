// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class CookieEvent extends Equatable {}

class GetCookieEvent extends CookieEvent {
  @override
  List<Object?> get props => [];
}

class SetCookieTimerEvent extends CookieEvent {
  int newTimer;
  SetCookieTimerEvent(this.newTimer);
  @override
  List<Object?> get props => [newTimer];
}

class SetCookieAdderEvent extends CookieEvent {
  int newAdder;
  SetCookieAdderEvent(this.newAdder);
  @override
  List<Object?> get props => [newAdder];
}

class AddCookieAmountEvent extends CookieEvent {
  @override
  List<Object?> get props => [];

}
