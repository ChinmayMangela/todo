import 'package:intl/intl.dart';

class DateFormatter {
  static final _dateFormatter = DateFormat('yMd');
  static final _timeFormatter = DateFormat.jm();

  static String formatDate(DateTime date) {
    return _dateFormatter.format(date);
  }

  static String formatTime(DateTime time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year - 1, now.month, now.day, time.hour, time.minute);
    final formattedTime = _timeFormatter.format(dateTime);
    return formattedTime;
  }
}
