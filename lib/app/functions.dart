import 'package:flutter/material.dart';

String capitalizeAllWord(String value) {
  var result = value[0].toUpperCase();
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " ") {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
    }
  }
  return result;
}

Color? colorFromHexString(String hexString) {
  if (hexString.isEmpty) {
    return null;
  }
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
// import 'package:flutter/material.dart';


// /// Checks if the `a` older than `b` by 1 day or more,
// /// for example: a= `2023-1-14` is older than b= `2023-1-15` --> returns `true`
// bool isOneOrMoreDaysOlder(DateTime a, DateTime b) {
//   // Create new DateTime objects with time set to 00:00:00 to ignore time
//   DateTime aWithoutTime = DateTime(a.year, a.month, a.day);
//   DateTime bWithoutTime = DateTime(b.year, b.month, b.day);

//   // Get the difference between a and b as a Duration
//   Duration difference = aWithoutTime.difference(bWithoutTime);

//   // Calculate the value of the difference in days
//   int daysDifference = difference.inDays;

//   // Check if the days difference is less than 0
//   return daysDifference < 0;
// }

// DateTime addTimeToDate(TimeOfDay time, DateTime date) {
//   return DateTime(date.year, date.month, date.day, time.hour, time.minute);
// }

// Weekday getWeekday(DateTime date) {
//   return Weekday.values[date.weekday - 1];
// }

// String getSessionTime(DateTime from, DateTime to, BuildContext context) {
//   final intl.DateFormat timeOnly = intl.DateFormat(
//       'h:mma', context.locale.toLanguageTag().replaceFirst('-', '_'));
//   String fromAsString = timeOnly.format(from);
//   String toAsString = timeOnly.format(to);
//   if (Directionality.of(context) == TextDirection.ltr) {
//     return '$fromAsString - $toAsString';
//   } else {
//     return '$toAsString - $fromAsString';
//   }
// }
