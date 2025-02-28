import 'package:flutter/material.dart';
import 'package:flutter_learning/models/task.dart';
import 'package:flutter_learning/services/database_services.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task>? tasks;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  getTasks() async {
    tasks = await DatabaseServices.getTasks();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('My Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => getTasks(),
          ),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: tasks?.length ?? 0,
                itemBuilder: (context, index) {
                  final task = tasks![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                        task.task,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap:
                          () => showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: const Text('ลบงาน'),
                                  content: Text(
                                    'คุณต้องการลบงาน "${task.task}" หรือไม่?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('ยกเลิก'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        setState(() => isLoading = true);
                                        try {
                                          bool success =
                                              await DatabaseServices.deleteTask(
                                                task.id,
                                              );
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  success
                                                      ? 'ลบรายการเรียบร้อย'
                                                      : 'ไม่สามารถลบรายการได้',
                                                  style: GoogleFonts.kanit(),
                                                ),
                                              ),
                                            );
                                          }
                                          await getTasks();
                                        } catch (e) {
                                          setState(() => isLoading = false);
                                          if (context.mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'เกิดข้อผิดพลาด: ${e.toString()}',
                                                  style: GoogleFonts.kanit(),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                        'ลบ',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                          ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final taskController = TextEditingController();
              return AlertDialog(
                title: Text('เพิ่มงานใหม่'),
                content: TextField(
                  controller: taskController,
                  decoration: const InputDecoration(
                    labelText: 'Task',
                    hintText: 'กรอกรายละเอียดงาน',
                    border: OutlineInputBorder(),
                  ),
                  autofocus: true,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('ยกเลิก'),
                  ),
                  FilledButton(
                    onPressed: () async {
                      if (taskController.text.isNotEmpty) {
                        setState(() => isLoading = true);
                        try {
                          await DatabaseServices.addTasks(taskController.text);
                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Task added successfully!'),
                              ),
                            );
                          }
                          await getTasks();
                        } catch (e) {
                          setState(() => isLoading = false);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.toString()}')),
                            );
                          }
                        }
                      }
                    },
                    child: const Text('เพิ่ม'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
