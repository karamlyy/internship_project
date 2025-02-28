import 'package:flutter/material.dart';
import 'package:language_learning/data/endpoint/auth/timing_endpoint.dart';

import '../model/time_interval.dart';

class TimingProvider with ChangeNotifier {


  int? _selectedIntervalId;
  bool _isIntervalSelected = false;

  DateTime? _startTime;
  DateTime? _endTime;

  int? get selectedIntervalId => _selectedIntervalId;

  bool? get isIntervalSelected => _isIntervalSelected;


  DateTime? get startTime => _startTime;

  DateTime? get endTime => _endTime;

  TimingInput get timingInput => TimingInput(
        intervalId: _selectedIntervalId,
        startTime: _startTime,
        endTime: _endTime,
      );

  void selectInterval(int id) {
    _selectedIntervalId = id;
    _isIntervalSelected = true;
    notifyListeners();
    print('Selected Interval ID: $id');
  }

  bool isSelectedInterval() {
    return _isIntervalSelected && _startTime != null && _endTime != null;
  }

  void setStartTime(DateTime time) {
    _startTime = time;
    notifyListeners();
    print('Start Time: $time');
  }

  void setEndTime(DateTime time) {
    _endTime = time;
    notifyListeners();
    print('End Time: $time');
  }
}
