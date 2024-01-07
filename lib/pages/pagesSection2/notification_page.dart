import 'package:flutter/material.dart';


class NotifyPage extends StatefulWidget{
   final String title;
  final String body;

   const NotifyPage({required this.title, required this.body, Key? key}) : super(key: key);
   @override
  State<StatefulWidget> createState() {
    return NotifyPageState();
  }
}

class NotifyPageState extends State<NotifyPage>{
  @override

  Widget build(BuildContext context) {
   return  Scaffold(
    backgroundColor: Colors.indigo.shade900,
    appBar: AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.indigo.shade900,
      title: const Text("Alert"),
    ),
    body:  Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
                style: BorderStyle.solid,
                color: Colors.white,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(  
             mainAxisSize: MainAxisSize.min,
              children: [
                 Container(
                  margin:const EdgeInsets.all(20.0),
                   child: const Text("Reminder:",
                   style: TextStyle(color: Colors.white,
                   fontWeight: FontWeight.bold,
                   fontSize: 35.0,
                   ),
                   
                   ),
                 ),
                 Container(
                  margin: const EdgeInsets.all(20.0),
                   child: Text("Name: ${widget.title}",
                   style: const TextStyle(color: Colors.white,
                   fontSize: 25.0),
                   ),
                 ),
                 Container(
                  margin: const EdgeInsets.all(20.0),
                   child: Text(widget.body,
                   style: const TextStyle(color: Colors.white,
                   fontSize: 25.0),
                   ),
                 ),
                
            
                Row(  
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(onPressed: (){
                        _showDialog(context,"Done!");
                        },
                        heroTag: const Text('done'),
                         mini: false, 
                                  
                          
                        child:const Text("Done!"),
                        ),
                      ),
                    ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(onPressed: (){
                      _showDialog1(context,"Please keep the reminder again as required!");
                    },
                    heroTag: const Text('later'),
                    child:const Text("I will do it later"),
                    ),
                  ),
                ),
                 ],
                 )
              ],
            ),
          ),
        ),
      ),
    );
   
  }

  _showDialog(BuildContext context, String printMessage){
    showDialog(context: context, 
    builder: (BuildContext context){
       return AlertDialog(
          title: const Text("Confirmation"),
          content:const Text("Dont forget to delete this remider, to keep your stack clean"),
          actions: [
            TextButton(
              onPressed: () {
               Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            ),
          ],
       );
    }
    );
  }
  _showDialog1(BuildContext context, String printMessage){
    showDialog(context: context, 
    builder: (BuildContext context){
       return AlertDialog(
          title: const Text("Confirmation"),
          content: Text(printMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text("Ok"),
            ),
          ],
       );
    }
    );
  }
}
