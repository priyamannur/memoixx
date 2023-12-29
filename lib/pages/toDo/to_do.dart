import 'package:flutter/material.dart';

class ToDo extends StatelessWidget{
  const ToDo({super.key});
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
                    'assets/images/todo.png',
                    height: 120.0,
                    width: 120.0,
                  fit: BoxFit.cover,),
              ),
            ),
           const SizedBox(height:25.0),
         const Expanded(
           child:  Text('To-Do List',
           style: TextStyle(fontSize: 27,
           color: Colors.white),
           ),
         ),
         const SizedBox(height:30.0),
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