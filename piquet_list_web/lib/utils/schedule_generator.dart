import 'package:flutter/material.dart';

List<String> generateScheduleOutput(TimeOfDay start, TimeOfDay end, List<String> members, String mode) {
  DateTime now = DateTime.now();
  DateTime startDateTime = DateTime(now.year, now.month, now.day, start.hour, start.minute);
  DateTime endDateTime = DateTime(now.year, now.month, now.day, end.hour, end.minute);
  if (endDateTime.isBefore(startDateTime)) {
    endDateTime = endDateTime.add(Duration(days: 1));
  }

  Duration totalDuration = endDateTime.difference(startDateTime);
  int count = members.length;
  Duration shiftLength = Duration(minutes: totalDuration.inMinutes ~/ count);
  List<String> schedule = [];

  for (int i = 0; i < count; i++) {
    DateTime shiftStart = startDateTime.add(shiftLength * i);
    DateTime shiftEnd = shiftStart.add(shiftLength);

    String timeSlot = "\${shiftStart.hour.toString().padLeft(2, '0')}:\${shiftStart.minute.toString().padLeft(2, '0')} - \${shiftEnd.hour.toString().padLeft(2, '0')}:\${shiftEnd.minute.toString().padLeft(2, '0')}";

    if (mode == 'Staggered') {
      schedule.add("\$timeSlot | \${members[i % members.length]}");
    } else {
      String first = members[i % members.length];
      String second = members[(i + 1) % members.length];
      schedule.add("\$timeSlot | \$first & \$second");
    }
  }

  return schedule;
}
