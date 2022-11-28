import 'package:table_calendar/table_calendar.dart';

extension StringExtension on String {
  StartingDayOfWeek get getStartingDayOfWeek {
    switch (this) {
      case 'Monday':
        return StartingDayOfWeek.monday;
      case 'Tuesday':
        return StartingDayOfWeek.tuesday;
      case 'Wednesday':
        return StartingDayOfWeek.wednesday;
      case 'Thursday':
        return StartingDayOfWeek.thursday;
      case 'Friday':
        return StartingDayOfWeek.friday;
      case 'Saturday':
        return StartingDayOfWeek.saturday;
      default:
        return StartingDayOfWeek.sunday;
    }
  }
}
