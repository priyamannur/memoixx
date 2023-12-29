import 'package:flutter/material.dart';
import 'package:memoixx/pages/billReminder/bill_alarm.dart';
class BillReminder extends StatefulWidget{
const BillReminder({super.key});

@override
  State<StatefulWidget> createState() {
    return BillRemPage();
  }
}
class BillRemPage extends State{
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
         const Expanded(
           child: Text('Set Bill Reminders',
           style: TextStyle(fontSize: 27,
           color: Colors.white),
           ),
         ),
         const Expanded(child: SizedBox(height:30.0)),
       Row(
        
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
         Container(
          margin:const EdgeInsets.only(right: 20,bottom: 20),
           child: SizedBox(
            width: 70,
            height: 70,
             child: FloatingActionButton(onPressed:(){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BillAlarm(),));
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
