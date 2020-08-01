import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list_2/models/task.dart';
import 'package:to_do_list_2/pages/task_detail.dart';
import 'package:to_do_list_2/utils/database_helper.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> taskList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (taskList == null) {
      taskList = List<Task>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(this.taskList[index].title, maxLines: 1),
                subtitle: Text(this.taskList[index].description, maxLines: 1),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _delete(context, this.taskList[index].id);
                  },
                ),
                onTap: () {
                  navigateToDetail(taskList[index], 'Edit Task');
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Task('', ''), 'Add Task');
        },
        child: Icon(Icons.add),
        tooltip: 'Add Task',
      ),
    );
  }

  void navigateToDetail(Task task, String title) async {
    bool response = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TaskDetail(
                task: task,
                title: title,
              )),
    );
    if (response == true)
      updateListView();
    else
      _showSnackBar(context, 'Unexpected error occurred');
  }

  void updateListView() async {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        setState(() {
          this.taskList = taskList;
          this.count = taskList.length;
        });
      });
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final SnackBar snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _delete(BuildContext context, int id) async {
    int result = await databaseHelper.deleteTask(id);
    if (result != 0) {
      _showSnackBar(context, 'Task deleted successfully');
      updateListView();
    } else {
      _showSnackBar(context, 'Error occurred while deleting task');
      updateListView();
    }
  }
}
