import 'package:table_calendar/table_calendar.dart';

extension StringExtension on String {
  StartingDayOfWeek get getStartingDayOfWeek {
    switch (this) {
      case 'Monday':
        return StartingDayOfWeek.monday;
      case 'Thứ hai':
        return StartingDayOfWeek.monday;
      case 'Tuesday':
        return StartingDayOfWeek.tuesday;
      case 'Thứ ba':
        return StartingDayOfWeek.tuesday;
      case 'Wednesday':
        return StartingDayOfWeek.wednesday;
      case 'Thứ tư':
        return StartingDayOfWeek.wednesday;
      case 'Thursday':
        return StartingDayOfWeek.thursday;
      case 'Thứ năm':
        return StartingDayOfWeek.thursday;
      case 'Friday':
        return StartingDayOfWeek.friday;
      case 'Thứ sáu':
        return StartingDayOfWeek.friday;
      case 'Saturday':
        return StartingDayOfWeek.saturday;
      case 'Thứ bảy':
        return StartingDayOfWeek.saturday;
      case 'Sunday':
        return StartingDayOfWeek.sunday;
      default:
        return StartingDayOfWeek.sunday;
    }
  }
}
