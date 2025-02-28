import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('My Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  // รูปโปรไฟล์
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage("assets/images/Patipat.JPG"),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ชื่อ
                  const Text(
                    'Patipat',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // ข้อความสถานะ
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'นักศึกษาปริญญาตรี',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ปุ่มแสดงผล
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.download_rounded),
                      label: const Text('Download Resume'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Implement file download functionality
                        // You'll need to:
                        // 1. Add url_launcher package to pubspec.yaml
                        // 2. Import 'package:url_launcher/url_launcher.dart'
                        // 3. Add the actual file URL and launch it
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 40),
            ),

            // ส่วนแสดงข้อมูลติดต่อ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 16),
                    child: Text(
                      'ข้อมูลติดต่อ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildInfoCard(
                    'Email',
                    'm.patipat.pao@gmail.com',
                    Icons.email,
                    Colors.red,
                  ),
                  _buildInfoCard(
                    'เบอร์โทร',
                    '(+66) 86-345-1537',
                    Icons.phone,
                    Colors.green,
                  ),
                  _buildInfoCard(
                    'ที่อยู่',
                    'Bangkok, Thailand',
                    Icons.location_on,
                    Colors.blue,
                  ),
                  _buildInfoCard(
                    'อาชีพ',
                    'นักศึกษาปริญญาตรี',
                    Icons.work,
                    Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ส่วนแสดงทักษะและความสามารถ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 16),
                    child: Text(
                      'ทักษะและความสามารถ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildSkillBar('Flutter', 0.85, Colors.blue),
                  const SizedBox(height: 12),
                  _buildSkillBar('Dart', 0.80, Colors.teal),
                  const SizedBox(height: 12),
                  _buildSkillBar('Firebase', 0.75, Colors.amber),
                  const SizedBox(height: 12),
                  _buildSkillBar('UI/UX Design', 0.70, Colors.purple),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // การ์ดแสดงข้อมูลติดต่อ
  Widget _buildInfoCard(
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(content),
        ),
      ),
    );
  }

  // แสดงแถบทักษะ
  Widget _buildSkillBar(String skill, double level, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(skill, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(
              '${(level * 100).toInt()}%',
              style: TextStyle(fontWeight: FontWeight.w500, color: color),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            FractionallySizedBox(
              widthFactor: level,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.7), color],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
