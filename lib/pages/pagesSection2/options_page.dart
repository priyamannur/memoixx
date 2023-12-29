import 'package:flutter/material.dart';
import '../billReminder/bill_reminder.dart';
import '../toDo/to_do.dart';
import 'package:memoixx/pages/generalReminder/gen_reminder_page.dart';
class OptionPage extends StatelessWidget{
  const OptionPage({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingValue = 50;
    if (screenWidth > 900) {
      paddingValue = 400.0;
    }
    return  Scaffold(
      appBar:AppBar(
        foregroundColor: Colors.white,
          backgroundColor: Colors.indigo.shade900,
        title: const Text('Select Options',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),)
      ) ,
  body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
       Container(
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: paddingValue),
                      child: FloatingActionButton(
                        heroTag: const Text('op1'),
                        onPressed: () {
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (context){
                            return const GenReminder();
                          })
                         );
                        },
                        tooltip: 'Get Started',
                        backgroundColor: Colors.indigo.shade900,
                        child: const Text('Set General Reminders'),
                      ),
                    ),
                  ),
                ),
              ),
             Container(
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                    child: Padding(
                       padding: EdgeInsets.symmetric(horizontal: paddingValue),
                      child: FloatingActionButton(
                        heroTag: const Text('op2'),
                        onPressed: () {
                         Navigator.of(context).push(
                          MaterialPageRoute(builder: (context){
                            return const BillReminder();
                          })
                         );
                        },
                        tooltip: 'Get Started',
                        backgroundColor: Colors.indigo.shade900,
                        child: const Text('Set Bill Reminders'),
                      ),
                    ),
                  ),
                ),
              ),
             Container(
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                    child: Padding(
                       padding: EdgeInsets.symmetric(horizontal: paddingValue),
                      child: FloatingActionButton(
                        heroTag: const Text('op3'),
                        onPressed: () {
                         Navigator.of(context).push(
                          MaterialPageRoute(builder: (context){
                            return const ToDo();
                          })
                         );
                        },
                        tooltip: 'Get Started',
                        backgroundColor: Colors.indigo.shade900,
                        child: const Text('To-do'),
                      ),
                    ),
                  ),
                ),
              ),
    ],
  )
    );
  }
}