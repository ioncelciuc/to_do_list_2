import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  int count = 20;

  @override
  Widget build(BuildContext context) {
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
                  title: Text('Titlu'),
                  subtitle: Text('Descriere'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      print('apasat pe delete');
                    },
                  )),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
      ),
    );
  }
}
