import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if thi is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ['Coding', false],
      ['Cooking', false],
      ['Cleaning', false],
      ['Shopping', false],
      ['Sleeping', false]
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  // update the databasee
  void updateDatabase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
