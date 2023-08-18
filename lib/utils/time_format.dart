import 'package:intl/intl.dart';

String formattedTimeStamp(DateTime timeData) {
  return DateFormat('h:mm a').format(timeData).toLowerCase();
}
