import 'package:flutter/material.dart';

class AppProviderClass with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;

  Future<void> selectedDateFunction(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2026),
        initialDate: _selectedDate);
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      notifyListeners();
    }
  }

  Future<void> selectedTimeFunction(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);

    if (picked != null) {
      final DateTime now = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        picked.hour,
        picked.minute,
      );

      if (selectedDateTime.isBefore(now)) {
        // If the selected time is in the past, set it to the current time
        _selectedTime = TimeOfDay.fromDateTime(now);
      } else {
        _selectedTime = picked;
      }

      notifyListeners();
    }
  }
}
