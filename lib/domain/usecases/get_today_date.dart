import '../../core/utils/date_formatter.dart';

String getTodayDate() {
  DateTime today = DateTime.now();

  return dateFormatter(today);
}
