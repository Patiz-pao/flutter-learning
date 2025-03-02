import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> launchURL() async {
    final Uri url = Uri.parse(
      'https://www.dropbox.com/scl/fi/25md071rsjdi9e9yly5wm/Resume-Patipat.pdf?rlkey=zgkf4tqkob72ocl8fa1n5vy9e&st=4exw256n&dl=0',
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.manage_accounts_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            color: Colors.white,
          ),
        ],
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(),
                          blurRadius: 10,
                          offset: const Offset(0, 1),
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
                    'Patipat Mangkara',
                    style: TextStyle(fontSize: 28),
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
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.remove_red_eye),
                      label: const Text('View Resume'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: launchURL,
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
                    Theme.of(context).colorScheme.primary,
                  ),
                  _buildInfoCard(
                    'เบอร์โทร',
                    '(+66) 86-345-1537',
                    Icons.phone,
                    Theme.of(context).colorScheme.primary,
                  ),
                  _buildInfoCard(
                    'ที่อยู่',
                    'Bangkok, Thailand',
                    Icons.location_on,
                    Theme.of(context).colorScheme.primary,
                  ),
                  _buildInfoCard(
                    'อาชีพ',
                    'นักศึกษาปริญญาตรี',
                    Icons.work,
                    Theme.of(context).colorScheme.primary,
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
                  // Programming Languages
                  const SizedBox(height: 12),
                  Text(
                    'Programming Languages',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildSkillBadges('Java', 0.85, Colors.green),
                  const SizedBox(height: 12),
                  _buildSkillBadges('Python', 0.80, Colors.green),
                  const SizedBox(height: 12),
                  _buildSkillBadges('TypeScript', 0.75, Colors.green),
                  const SizedBox(height: 12),
                  _buildSkillBadges('JavaScript', 0.75, Colors.green),
                  const SizedBox(height: 12),
                  _buildSkillBadges('Kotlin', 0.70, Colors.purple),
                  const SizedBox(height: 12),
                  _buildSkillBadges('C/C++', 0.65, Colors.blue),
                  const SizedBox(height: 12),
                  _buildSkillBadges('C#', 0.60, Colors.blue),

                  const SizedBox(height: 12),
                  // Frontend
                  Text(
                    'Frontend',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildSkillBadges('React', 0.80, Colors.green),
                  const SizedBox(height: 12),
                  _buildSkillBadges('Next.js', 0.75, Colors.green),
                  const SizedBox(height: 12),
                  _buildSkillBadges('Tailwind CSS', 0.85, Colors.green),
                  const SizedBox(height: 12),
                  _buildSkillBadges('HTML/CSS', 0.90, Colors.orange),

                  const SizedBox(height: 12),
                  // Backend & Database
                  Text(
                    'Backend & Database',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildSkillBadges('Spring Boot', 0.75, Colors.green),
                  const SizedBox(height: 12),
                  _buildSkillBadges('MySQL', 0.80, Colors.green),
                  const SizedBox(height: 12),

                  const SizedBox(height: 12),
                  // Version Control
                  Text(
                    'Version Control',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildSkillBadges('Git/GitHub', 0.85, Colors.green),
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

  Widget _buildSkillBadges(String skill, double level, Color color) {
    String levelText;

    if (level >= 0.9) {
      levelText = "Expert";
    } else if (level >= 0.75) {
      levelText = "Advanced";
    } else if (level >= 0.6) {
      levelText = "Intermediate";
    } else {
      levelText = "Beginner";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              skill,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, color: color, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      levelText,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
