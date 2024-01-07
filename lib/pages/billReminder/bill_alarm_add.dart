import 'package:flutter/material.dart';
import 'package:memoixx/pages/pagesSection2/alarm_database_helper.dart';
import 'package:memoixx/pages/pagesSection2/notification_helper.dart';

class BillAlarm extends StatefulWidget {
  const BillAlarm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddBill();
  }
}

class AddBill extends State<BillAlarm> {
String var1="";

  String var2 = ""; 

  String var3 = "";

  final TextEditingController _messageControllerr = TextEditingController();

  final TextEditingController _messageControllerr1 = TextEditingController();

  final TextEditingController _messageControllerr2 = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  int selectedHour = TimeOfDay.now().hour;

  int selectedMinute = TimeOfDay.now().minute;

  bool isAm= DateTime.now().hour < 12;

  DateTime myDateTime = DateTime.now();

  Future<void> _showDialog(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context, 
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(const Duration(days: 365)));

    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ,
    );
    if(pickedDate==null)
      return;
    if(picked==null)
      return;
    final pickedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      picked.hour,
      picked.minute,
    );
    if(pickedDateTime.isBefore(DateTime.now())){
       showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select a future date and time.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    }
    
      setState(() {
        selectedTime = picked;
        selectedHour = picked.hour;
        selectedMinute = picked.minute;
        isAm=picked.period == DayPeriod.am;

        var1 = (selectedHour).toString();
        var2 = selectedMinute.toString();
        if(var1.length==1){
          var1 = '0$var1'; 
        }
        if(var2.length==1){
          var2 = '0$var2';
        }

        if(isAm){
          var3 = "AM";
        }
        else{
          var3="PM";
        }

       myDateTime = pickedDateTime;

      });
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
                           _buildTimeBox('${myDateTime.year}-${myDateTime.month}-${myDateTime.day}','Date',),
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
                controller: _messageControllerr,
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
                controller: _messageControllerr1,
                decoration: const InputDecoration(
                   label: Text('Bill Price'),
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
                controller: _messageControllerr2,
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
                child: FloatingActionButton(onPressed: () async{
                 AlarmHelper dbHelper = AlarmHelper();
                 await dbHelper.initializeDatabase();
                BillAlarmAdd new_alarm = BillAlarmAdd(idb: (await AlarmHelper().getMostRecentBillValue())+1,dateTimeb: myDateTime,textb: _messageControllerr.text.toString(),textdescb: _messageControllerr2.text.toString(),priceb: _messageControllerr1.text.toString());
                dbHelper.insertBillAlarm(new_alarm);
                 Navigator.pop(context,new_alarm);
                List<BillAlarmAdd> als =await dbHelper.getBillAlarms();
               NotificationsHelper.initialize();
                 NotificationsHelper.showNotifications(als);
                },
                heroTag: const Text('u3'),
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