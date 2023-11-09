import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];
  //reference our box
  final _todo = Hive.box('todo');
//run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["BrotoType,Kochi ", false],
      ["Flutter", false]
    ];
  }

//load the data from database
  void loadData() {
    toDoList = _todo.get('TODOLIST');
  }

//UPDDATE THE DATABASE
  void updateDataBase() {
    _todo.put("TODOLIST", toDoList);
  }
}
