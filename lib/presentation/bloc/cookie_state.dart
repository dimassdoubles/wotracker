import 'package:equatable/equatable.dart';
import 'package:wotracker/domain/entities/cookie.dart';

abstract class CookieState extends Equatable {}

class InitialState extends CookieState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends CookieState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends CookieState {
  Cookie cookie;

  LoadedState(this.cookie);

  @override
  List<Object?> get props => [cookie];
}

class ErrorState extends CookieState {
  String message;
  ErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
