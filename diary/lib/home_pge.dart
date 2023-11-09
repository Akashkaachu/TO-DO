import 'package:diary/data/database.dart';
import 'package:diary/util/dialog_box.dart';
import 'package:diary/util/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePge extends StatefulWidget {
  const HomePge({super.key});

  @override
  State<HomePge> createState() => _HomePgeState();
}

class _HomePgeState extends State<HomePge> {
  //reference   the hivebox
  final _todo = Hive.box('todo');
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
    if (_todo.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  //text editing controller
  final _controller = TextEditingController();

  //for checkbox
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  } //save new task

  void addNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create new task for floatingAction

  void createTask() {
    showDialog(
        context: context,
        builder: (context) {
          return ShowDialog(
            controller: _controller,
            onsave: () => addNewTask(),
            oncancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.yellow,
          title: const Text("TO DO", style: TextStyle(color: Colors.black)),
          elevation: 0,
        ),
        floatingActionButton: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: FloatingActionButton(
              backgroundColor: Colors.yellow,
              onPressed: () {
                createTask();
              },
              child: const Icon(
                Icons.add,
                color: Colors.black,
              )),
        ),
        body: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChange: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
              );
            }));
  }
}
