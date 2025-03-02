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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(
          'My Todo List',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Header section with summary
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 15,
              bottom: 25,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'สรุปงานของคุณ',
                  style: GoogleFonts.kanit(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryCard(
                      'งานทั้งหมด',
                      '${tasks?.length ?? 0}',
                      Icons.assignment,
                      Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tasks list title
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'รายการงานของคุณ',
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.black87),
                  onPressed: () {
                    getTasks();
                  },
                ),
              ],
            ),
          ),

          // Tasks list
          Expanded(
            child:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : tasks!.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 80,
                        left: 16,
                        right: 16,
                      ),
                      itemCount: tasks?.length ?? 0,
                      itemBuilder: (context, index) {
                        final task = tasks![index];
                        return _buildTaskCard(context, task, index);
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'เพิ่มงานใหม่',
          style: GoogleFonts.kanit(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.kanit(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(BuildContext context, Task task, int index) {
    return Dismissible(
      key: Key(task.id.toString()),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await _showDeleteConfirmDialog(context, task);
      },
      onDismissed: (direction) async {
        // การลบได้ถูกจัดการผ่าน confirmDismiss แล้ว
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          title: Text(
            task.task,
            style: GoogleFonts.kanit(fontWeight: FontWeight.w500, fontSize: 16),
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ปุ่มแก้ไข
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  size: 20,
                ),
                onPressed: () {
                  _showEditTaskDialog(context, task);
                },
              ),
              // ปุ่มลบ
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                onPressed: () async {
                  final confirm = await _showDeleteConfirmDialog(context, task);
                  if (confirm == true) {
                    // ลบงานเรียบร้อยแล้ว
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            'ไม่มีงานที่ต้องทำ',
            style: GoogleFonts.kanit(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'กดปุ่ม "เพิ่มงานใหม่" เพื่อเริ่มสร้างรายการงาน',
            style: GoogleFonts.kanit(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<bool?> _showDeleteConfirmDialog(BuildContext context, Task task) {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'ลบงาน',
              style: GoogleFonts.kanit(fontWeight: FontWeight.w600),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.delete_forever, color: Colors.red, size: 56),
                const SizedBox(height: 16),
                Text(
                  'คุณต้องการลบงาน "${task.task}" หรือไม่?',
                  style: GoogleFonts.kanit(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('ยกเลิก', style: GoogleFonts.kanit()),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  setState(() => isLoading = true);
                  try {
                    bool success = await DatabaseServices.deleteTask(task.id);
                    if (context.mounted) {
                      Navigator.pop(context, true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            success
                                ? 'ลบรายการเรียบร้อย'
                                : 'ไม่สามารถลบรายการได้',
                            style: GoogleFonts.kanit(),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                    await getTasks();
                  } catch (e) {
                    setState(() => isLoading = false);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
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
                child: Text('ลบ', style: GoogleFonts.kanit()),
              ),
            ],
          ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final taskController = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'เพิ่มงานใหม่',
            style: GoogleFonts.kanit(fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  labelText: 'รายละเอียดงาน',
                  labelStyle: GoogleFonts.kanit(),
                  hintText: 'กรอกรายละเอียดงาน',
                  hintStyle: GoogleFonts.kanit(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.assignment),
                ),
                autofocus: true,
                style: GoogleFonts.kanit(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ยกเลิก', style: GoogleFonts.kanit()),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (taskController.text.isNotEmpty) {
                  setState(() => isLoading = true);
                  try {
                    await DatabaseServices.addTasks(taskController.text);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'เพิ่มงานเรียบร้อย!',
                            style: GoogleFonts.kanit(),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                    await getTasks();
                  } catch (e) {
                    setState(() => isLoading = false);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'เกิดข้อผิดพลาด: ${e.toString()}',
                            style: GoogleFonts.kanit(),
                          ),
                        ),
                      );
                    }
                  }
                }
              },
              child: Text('เพิ่ม', style: GoogleFonts.kanit()),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, Task task) {
    final taskController = TextEditingController(text: task.task);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'แก้ไขงาน',
            style: GoogleFonts.kanit(fontWeight: FontWeight.w600),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  labelText: 'รายละเอียดงาน',
                  labelStyle: GoogleFonts.kanit(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.edit_note),
                ),
                autofocus: true,
                style: GoogleFonts.kanit(),
                keyboardType:
                    TextInputType.text, // ใช้คีย์บอร์ดที่รองรับการพิมพ์
                enableIMEPersonalizedLearning:
                    true, // เปิดการเรียนรู้ของคีย์บอร์ด
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ยกเลิก', style: GoogleFonts.kanit()),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (taskController.text.isNotEmpty) {
                  setState(() => isLoading = true);
                  try {
                    Task taskReq = Task(id: task.id, task: taskController.text);
                    await DatabaseServices.updateTask(taskReq);
                    await getTasks();
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'อัพเดทงานเรียบร้อย!',
                            style: GoogleFonts.kanit(),
                          ),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    setState(() => isLoading = false);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'เกิดข้อผิดพลาด: ${e.toString()}',
                            style: GoogleFonts.kanit(),
                          ),
                        ),
                      );
                    }
                  }
                }
              },
              child: Text('บันทึก', style: GoogleFonts.kanit()),
            ),
          ],
        );
      },
    );
  }
}
