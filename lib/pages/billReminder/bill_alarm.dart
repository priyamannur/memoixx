import 'package:flutter/material.dart';

class BillAlarm extends StatefulWidget {
  const BillAlarm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddBill();
  }
}

class AddBill extends State<BillAlarm> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _messageController1 = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  int selectedHour = TimeOfDay.now().hour;
  int selectedMinute = TimeOfDay.now().minute;
  bool isAm= DateTime.now().hour < 12;
  Future<void> _showDialog(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        selectedHour = picked.hour;
        selectedMinute = picked.minute;
        isAm=picked.period == DayPeriod.am;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Reminders'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTimeBox(selectedHour % 12 == 0 ? '12' : (selectedHour % 12).toString(), 'Hours'),
                          _buildTimeBox(selectedMinute.toString().padLeft(2, '0'), 'Minutes'),
                          _buildTimeBox(isAm ? 'AM' : 'PM', 'AM/PM'),
                        ],
                      ),
            ), Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      margin: const EdgeInsets.only(top: 30,bottom: 20),
                      child: FloatingActionButton(
                                onPressed: () => _showDialog(context),
                                child: const Text('Set Time'),
                              ),
                    ),
        Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                   label: Text('Bill Name'),
                   labelStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                  hintText: 'Enter Text',
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _messageController1,
                decoration: const InputDecoration(
                  label: Text('Bill Notes'),
                   labelStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                  hintText: 'Enter Description',
                  contentPadding: EdgeInsets.all(20),
                   enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(onPressed: (){
                  Navigator.of(context).pop();
                },heroTag: const Text('u3'),
                child: const Text('Set Reminder'),),
              ),
            ),
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: FloatingActionButton(onPressed: (){
                   
                         },heroTag: const Text('u4'),
                         child: const Text('Cancel')),
               ),
             )
          ],
        )]
        ),
      ),
    );
  }
}
Widget _buildTimeBox(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }