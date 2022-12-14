import 'package:equatable/equatable.dart';
import 'record.dart';

// ignore: must_be_immutable
class Cookie extends Equatable {
  int timer;
  int adder;
  List<Record> records;

  Cookie({required this.timer, required this.adder, required this.records});

  @override
  List<Object?> get props => [timer, adder, records];
}
