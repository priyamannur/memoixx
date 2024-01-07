import 'package:flutter/material.dart';
import 'package:memoixx/pages/billReminder/bill_alarm_add.dart';
import 'package:memoixx/pages/pagesSection2/alarm_database_helper.dart';
import 'package:memoixx/pages/pagesSection2/notification_helper.dart';

class BillReminder extends StatefulWidget{
const BillReminder({super.key});

@override
  State<StatefulWidget> createState() {
    return BillRemPage();
  }
}
class BillRemPage extends State{

   List<BillAlarmAdd> alarms = [];
   @override
void initState()  {
    super.initState();
     initializeAlarms(); 
  }

    Future<void> initializeAlarms() async {
  // Fetch alarms from the database
  AlarmHelper alh =AlarmHelper();
 List<BillAlarmAdd> fetchedAlarms = await alh.getBillAlarms();

  setState(() {
    alarms = fetchedAlarms;
  });
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.indigo.shade900,
  appBar: AppBar(
    foregroundColor: Colors.white,
  ),
      body: Column(
          children: [
            Center(
              child: ClipRRect(
                 borderRadius: BorderRadius.circular(150.0), // Adjust the border radius as needed
                child: 
                  Image.asset(
                    'assets/images/casho.jpg',
                    height: 120.0,
                    width: 120.0,
                  fit: BoxFit.cover,),
              ),
            ),
           const SizedBox(height:25.0),
         const Text('Set Bill Reminders',
         style: TextStyle(fontSize: 27,
         color: Colors.white),
         ),
       const SizedBox(height: 25.0),
          Expanded(
    child: ListView.builder(
    itemCount: alarms.length,
    
    //Iterates through all of the list and creates a list tile out of each ALarm object
    //That is stored forever on the page
    //This is because we are connected to a database , that has a table and that table is fetched every time we fall to this page
    
    
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(28.0),
        ),
    
        //This is the ListTile
    
        child: ListTile(
    
    //text
          title: Text(
            alarms[index].textb.toString(), 
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          //subtitle
          subtitle: Text(
            'Price:${alarms[index].priceb.toString()}', 
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
    //trailing
          trailing: Row(
            mainAxisSize: MainAxisSize.min ,
            children: [
              Text(
               'Time: ${alarms[index].dateTimeb.hour.toString().padLeft(2, '0')}:${alarms[index].dateTimeb.minute.toString().padLeft(2, '0')}',                  // Display the date and time as a string
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.white,
            onPressed: () async {
               AlarmHelper dbHelper =AlarmHelper();
                  await dbHelper.initializeDatabase();
              await AlarmHelper().deleteBillAlarm(alarms[index].idb);
              NotificationsHelper().deleteNotification(alarms[index]);
              setState(() {
                alarms.removeAt(index);
              });
            },
          ),
          
            ],
          ),
        ),
      );
    },
    ),
  ),
       Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
         Container(
          margin:const EdgeInsets.only(right: 20,bottom: 20),
           child: SizedBox(
            width: 70,
            height: 70,
             child: FloatingActionButton(onPressed:() async{
              //await because only after the list is obtained we set;
             var result = await Navigator.of(context).push(MaterialPageRoute(builder: (context){
               return const BillAlarm();
               }));
               setState((){
              {
                if(result!=null){
              alarms.add(result);
                }
                }
        });
             },
             
                  child:const Icon(Icons.add_circle_outline_rounded,
                    color: Colors.white,
                    size: 60.0,),
                         ),
           ),
         ),
             ],
         )
          ],
      
        ),
          );
  }
}
