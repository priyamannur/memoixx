import 'package:flutter/material.dart';
import 'package:memoixx/pages/pagesSection2/alarm_database_helper.dart';
import 'package:memoixx/pages/pagesSection2/notification_helper.dart';

class AddAlarm extends StatefulWidget {

    const AddAlarm({super.key});



  @override
  State<StatefulWidget> createState() {
     return Alarmadd();
  }
}




class Alarmadd extends State<AddAlarm> {

  Alarmadd();

  String var1="";

  String var2 = ""; 

  String var3 = "";

  final TextEditingController _messageController = TextEditingController();

  final TextEditingController _messageController1 = TextEditingController();

  TimeOfDay selectedTime = TimeOfDay.now();

  int selectedHour = TimeOfDay.now().hour;

  int selectedMinute = TimeOfDay.now().minute;

  bool isAm= DateTime.now().hour < 12;

  DateTime now = DateTime.now();

  DateTime myDateTime = DateTime.now();


  Future<void> _showDialog(BuildContext context) async {
    
      DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: myDateTime,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)), // Allow selection for one year
  );
  if(pickedDate==null){
    pickedDate = DateTime.now();
  }
  final picked;
    picked = await showTimePicker(
    context: context,
      initialTime: selectedTime,
    );
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
    

    if (picked!=null ) {
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
                          _buildTimeBox(selectedHour % 12 == 0 ? '12' : (selectedHour).toString(), 'Hours'),
                          _buildTimeBox(selectedMinute.toString().padLeft(2, '0'), 'Minutes'),
                          _buildTimeBox(isAm ? 'AM' : 'PM', 'AM/PM'),
                        ],
                      ),
            ), 
            
            Container(
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
                  label: Text('Reminder Name'),
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
                  label: Text('Reminder Description'),
                  hintText: 'Enter Description',
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                    enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                  ),
                  contentPadding: EdgeInsets.all(20),
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
                padding: const EdgeInsets.all(9.0),
                
                child: 

                FloatingActionButton(onPressed:() async {
                  //backend
                  AlarmHelper dbHelper =AlarmHelper();
                  await dbHelper.initializeDatabase();
                  Alarm newAlarm =  Alarm(id: (await AlarmHelper().getMostRecentValue()) + 1,dateTime:myDateTime  , text:_messageController.text.toString() , textdesc:  _messageController1.text.toString());
                  dbHelper.insertAlarm(newAlarm);//Insert Alarm to db     ***also converts the added data to map    List of alarm objects, that were converted to it from being maps.                                                                                            
                 Navigator.pop(context,newAlarm);
              List<Alarm> als =await dbHelper.getAlarms();
              NotificationsHelper.initialize();
                 NotificationsHelper.showNotifications(als);
                          },

                heroTag: const Text('s'),
                child: const Text('Set Reminder'),

                ),
              ),
            ),
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.all(9.0),
                 child: FloatingActionButton(onPressed: (){
                       Navigator.of(context).pop();
                         },heroTag: const Text('c'),
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