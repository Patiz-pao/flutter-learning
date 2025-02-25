import 'package:flutter/material.dart';
import 'package:flutter_learning/models/task.dart';
import 'package:flutter_learning/services/database_services.dart';
import 'dart:developer' as developer;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> tasks = []; // เปลี่ยนชื่อตัวแปรจาก task เป็น tasks
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    try {
      final loadedTasks = await DatabaseServices.getTasks();
      developer.log('Loaded tasks: ${loadedTasks.length}');
      setState(() {
        tasks = loadedTasks;
        isLoading = false;
      });
    } catch (e) {
      developer.log('Error loading tasks: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : tasks.isEmpty
              ? const Center(child: Text('No tasks found'))
              : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.task),
                  );
                },
              ),
    );
  }
}
