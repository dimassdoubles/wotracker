import 'package:equatable/equatable.dart';
class Record extends Equatable {
  // format date: "1 September"
  String date;
  int amount;

  Record(this.date, this.amount);

  @override
  List<Object?> get props => [date, amount];
}
