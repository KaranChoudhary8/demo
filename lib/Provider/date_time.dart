import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeProvider extends ChangeNotifier{
  String _date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _time = "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}";
  // String _date = HomePage.currentDate;
  // String _time = HomePage.currentTime;

  String get date => _date;
  String get time => _time;

  void setDate(String newDate){
    _date = newDate;
    notifyListeners();
  }
  void setTime(String newTime){
    _time = newTime;
    notifyListeners();
  }
}