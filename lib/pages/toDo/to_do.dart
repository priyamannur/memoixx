

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ToDo extends StatefulWidget{

  const ToDo({super.key});
  @override
  State<StatefulWidget> createState() {
    return todoList();
 
   
  }
}
 
 class todoList extends State{

  late SharedPreferences _prefs;
  late TextEditingController _textEditingController;
  List<String> _todoItems = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _loadTodoList();
  }

  Future<void> _loadTodoList() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _todoItems = _prefs.getStringList('todoItems') ?? [];
    });
  }

  Future<void> _saveTodoList() async {
    await _prefs.setStringList('todoItems', _todoItems);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _saveTodoList(); // Save the todo list when the widget is disposed
    super.dispose();
  }

  void _addTodoItem(String task) {
    setState(() {
      _todoItems.add(task);
    });
    _textEditingController.clear();
    _saveTodoList(); // Save the todo list after adding an item
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
    _saveTodoList(); // Save the todo list after removing an item
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (BuildContext context, int index) {
        return 
        
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            border: Border.all(
                style: BorderStyle.solid,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(28.0)
            )
          ,
          child: ListTile(
            title: Text(_todoItems[index],
            style: const TextStyle(color: Colors.white),),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.white,),
              onPressed: () => _removeTodoItem(index),
            ),
          ),
        );
      },
    );
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
                    'assets/images/todo.png',
                    height: 120.0,
                    width: 120.0,
                  fit: BoxFit.cover,),
              ),
            ),
           const SizedBox(height:25.0),
         const Text('To-Do List',
         style: TextStyle(fontSize: 27,
         color: Colors.white),
         ),
         const SizedBox(height:25.0),
         Expanded(
            child: _todoItems.isEmpty
                ? const Center(child: Text('No tasks added yet!',
                style: TextStyle(color: Colors.white),
                ),
                )
                : _buildTodoList(),
          ),
          Container(
          margin:const EdgeInsets.only(right: 20,bottom: 20),
         child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter a task...',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          )
                        ),
                        
                        onSubmitted: (value) => _addTodoItem(value),
                      ),
                    ),
                  ),
          SizedBox(
            width: 70,
            height: 70,
             child: FloatingActionButton(onPressed: () => _addTodoItem(_textEditingController.text),
                  child:const Icon(Icons.add_circle_outline_rounded,
                    color: Colors.white,
                    size: 60.0,),
                         ),
           ),]
         ),
          )
             ]
         )

        );
  }
     
  }

