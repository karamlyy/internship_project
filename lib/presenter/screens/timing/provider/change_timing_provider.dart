import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:language_learning/data/endpoint/auth/timing_endpoint.dart';
import 'package:language_learning/data/endpoint/settings/change_timing_endpoint.dart';
import 'package:language_learning/presenter/screens/auth/timing/model/time_interval.dart';


class ChangeTimingProvider with ChangeNotifier {
  final List<TimeInterval> intervals = [
    TimeInterval(id: 1, title: '15min'),
    TimeInterval(id: 2, title: '30min'),
    TimeInterval(id: 3, title: '1 hour'),
  ];

  int? _selectedIntervalId;
  bool _isIntervalSelected = false;

  DateTime? _startTime;
  DateTime? _endTime;

  int? _initialIntervalId;
  DateTime? _initialStartTime;
  DateTime? _initialEndTime;

  int? get selectedIntervalId => _selectedIntervalId;
  bool? get isIntervalSelected => _isIntervalSelected;
  DateTime? get startTime => _startTime;
  DateTime? get endTime => _endTime;

  void initialize({required int intervalId, required String startTime, required String endTime}) {
    _initialIntervalId = intervalId;
    _initialStartTime = _parseTimeString(startTime);
    _initialEndTime = _parseTimeString(endTime);

    _selectedIntervalId ??= _initialIntervalId;
    _startTime ??= _initialStartTime;
    _endTime ??= _initialEndTime;

    notifyListeners();
  }

  ChangeTimingInput get timingInput => ChangeTimingInput(
    intervalId: _selectedIntervalId ?? _initialIntervalId,
    startTime: _startTime ?? _initialStartTime,
    endTime: _endTime ?? _initialEndTime,
  );

  void selectInterval(int id) {
    _selectedIntervalId = id;
    _isIntervalSelected = true;
    notifyListeners();
    print('Selected Interval ID: $id');
  }

  bool isSelectedInterval() {
    return _isIntervalSelected && _selectedIntervalId != null;
  }

  void setStartTime(DateTime time) {
    _startTime = time;
    notifyListeners();
    print('Start Time (UTC+4): $time');
  }

  void setEndTime(DateTime time) {
    _endTime = time;
    notifyListeners();
    print('End Time (UTC+4): $time');
  }

  bool get isFormValid {
    return _isIntervalSelected || _selectedIntervalId != null || _startTime != null || _endTime != null;
  }

  DateTime? _parseTimeString(String timeString) {
    try {
      return DateFormat.Hm().parse(timeString, true);
    } catch (e) {
      return null;
    }
  }
}

