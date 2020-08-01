import 'package:flutter/material.dart';
import 'package:to_do_list_2/models/task.dart';
import 'package:to_do_list_2/utils/database_helper.dart';

class TaskDetail extends StatefulWidget {
  final Task task;
  final String title;

  TaskDetail({this.task, this.title});

  @override
  _TaskDetailState createState() => _TaskDetailState(task: task, title: title);
}

class _TaskDetailState extends State<TaskDetail> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Task task;
  String title;

  _TaskDetailState({this.task, this.title});

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    titleController.text = task.title;
    descriptionController.text = task.description;

    return WillPopScope(
      onWillPop: () {
        navigateToLastScreen();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              navigateToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        onPressed: () {
                          task.title = titleController.text;
                          task.description = descriptionController.text;
                          _save(context, task);
                        },
                        child: Text('SAVE', textScaleFactor: 1.5),
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        onPressed: () {
                          _delete(task.id);
                        },
                        child: Text('DELETE', textScaleFactor: 1.5),
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save(BuildContext context, Task task) async {
    navigateToLastScreen();
    int result;
    if (task.id == null) {
      result = await databaseHelper.insertTask(task);
    } else {
      result = await databaseHelper.updateTask(task);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Task saved successfully');
    } else {
      _showAlertDialog('Status', 'Error occurred while saving Task');
    }
  }

  void _delete(int id) async {
    navigateToLastScreen();
    if (id == null) {
      _showAlertDialog('Status', 'New note was deleted');
      return;
    }
    int response = await databaseHelper.deleteTask(id);
    if (response != 0) {
      _showAlertDialog('Status', 'Note deleted successfully');
    } else {
      _showAlertDialog('Status', 'Error occurred while deleting note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

}
