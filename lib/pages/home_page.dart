import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_todo_list/data/database.dart';
import 'package:my_todo_list/util/dialog_box.dart';
import 'package:my_todo_list/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();
    // if this is the first time of running this app, then create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // Already existed data
      db.loadData();
    }
  }

  //text controller
  final _controller = TextEditingController();

  // List of todo task
  // List toDoList = [
  //   ['Coding', false],
  //   ['Cooking', false],
  //   ['Cleaning', false],
  //   ['Shopping', false],
  //   ['Sleeping', false]
  // ];

  void checkBoxChange(String value, int index) {
    setState(
      () {
        db.toDoList[index][1] = !db.toDoList[index][1];
      },
    );
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(
      () {
        db.toDoList.add(
          [_controller.text, false],
        );
        _controller.clear();
      },
    );
    Navigator.of(context).pop();
  }

  // Create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controllerBox: _controller,
          onSave: saveNewTask,
          // Just to pop the dialog box
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  // Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text('TO DO'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: ((context, index) => ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: ((value) => checkBoxChange(value.toString(), index)),
              deleteFunction: (context) => deleteTask(index),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
