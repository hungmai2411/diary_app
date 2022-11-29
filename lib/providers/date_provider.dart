import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;

  void setDay(DateTime day) {
    _selectedDay = day;
    _focusedDay = day;
    notifyListeners();
  }
}
