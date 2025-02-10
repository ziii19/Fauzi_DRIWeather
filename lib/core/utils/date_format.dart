import 'package:intl/intl.dart';

String formatTimeddMMMM(String time) {
  final dateTime = DateTime.parse(time);

  final formatter = DateFormat('dd MMMM');
  final formattedDate = 'Today, ${formatter.format(dateTime)}';

  return formattedDate;
}

String formatTimeMMMdd(String time) {
  final dateTime = DateTime.parse(time);

  final formatter = DateFormat('MMM, dd');
  return formatter.format(dateTime);
}

String formatTimeHHmm(String isoString) {
  final dateTime = DateTime.parse(isoString);
  final formatter = DateFormat('HH:mm');
  return formatter.format(dateTime);
}
