import 'package:flutter/material.dart';

class Utilis {
  TimeOfDay convertStringToTimeOfDay(String timeString) {
    final format =
        DateTime.parse(timeString); // Assuming timeString is in AM/PM format
    return TimeOfDay(
      hour: format.hour,
      minute: format.minute,
    );
  }
}
