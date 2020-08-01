import 'package:flutter/material.dart';
import 'package:to_do_list_2/pages/task_detail.dart';
import 'package:to_do_list_2/pages/task_list.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TaskDetail(),
      ),
    );
