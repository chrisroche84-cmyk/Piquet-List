import 'package:flutter/material.dart';
import '../utils/schedule_generator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TimeOfDay startTime = TimeOfDay(hour: 22, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 6, minute: 0);
  String shiftMode = 'Staggered';
  List<String> members = [
    'Member 1',
    'Member 2',
    'Member 3',
    'Member 4',
    'Member 5',
    'Member 6',
    'Member 7',
    'Member 8'
  ];
  List<String> results = [];

  void generateSchedule() {
    results = generateScheduleOutput(
      startTime,
      endTime,
      members,
      shiftMode,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Piquet List Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: ${startTime.format(context)}'),
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? picked = await showTimePicker(
                        context: context, initialTime: startTime);
                    if (picked != null) {
                      setState(() {
                        startTime = picked;
                      });
                    }
                  },
                  child: Text('Pick Start'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('End: ${endTime.format(context)}'),
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? picked = await showTimePicker(
                        context: context, initialTime: endTime);
                    if (picked != null) {
                      setState(() {
                        endTime = picked;
                      });
                    }
                  },
                  child: Text('Pick End'),
                ),
              ],
            ),
            DropdownButton<String>(
              value: shiftMode,
              onChanged: (String? newValue) {
                setState(() {
                  shiftMode = newValue!;
                });
              },
              items: <String>['Staggered', 'Double']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('$value Staggered'),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: generateSchedule,
              child: Text('Generate Schedule'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(results[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
