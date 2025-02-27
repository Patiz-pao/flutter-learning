import 'package:flutter/material.dart';
import 'package:flutter_learning/models/list_book.dart';
import 'package:flutter_learning/services/database_services.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ส่วนค้นหา
            _buildSearchBar(),

            // ส่วนหมวดหมู่
            _buildCategorySection(),

            // ส่วนแสดงรายการหนังสือ
            _buildBookListSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        style: GoogleFonts.kanit(),
        decoration: InputDecoration(
          hintText: "ค้นหาหนังสือ...",
          hintStyle: GoogleFonts.kanit(),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'หมวดหมู่ยอดนิยม',
            style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildCategoryCard('นิยาย', Icons.book),
              _buildCategoryCard('การ์ตูน', Icons.collections_bookmark),
              _buildCategoryCard('ธุรกิจ', Icons.business),
              _buildCategoryCard('วิทยาศาสตร์', Icons.science),
            ],
          ),
        ),
      ],
    );
  }

  // Widget สำหรับส่วนแสดงรายการหนังสือ
  Widget _buildBookListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'รายการหนังสือ',
            style: GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildBookGrid(),
        ),
      ],
    );
  }
}

// Widget การ์ดหมวดหมู่
Widget _buildCategoryCard(String title, IconData icon) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Container(
      width: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 35, color: Colors.black87),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.kanit(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget _buildBookCard(String title, String price) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(Icons.book, size: 64, color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.kanit(fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            price,
            style: GoogleFonts.kanit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget แสดงกริดหนังสือ
Widget _buildBookGrid() {
  return FutureBuilder<List<ListBook>>(
    future: DatabaseServices.getBooks(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(
          child: Text(
            'เกิดข้อผิดพลาด: ${snapshot.error}',
            style: GoogleFonts.kanit(),
          ),
        );
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(
          child: Text('ไม่พบข้อมูลหนังสือ', style: GoogleFonts.kanit()),
        );
      }

      double screenWidth = MediaQuery.of(context).size.width;
      int crossAxisCount;
      double aspectRatio;

      if (screenWidth < 400) {
        crossAxisCount = 1;
        aspectRatio = 1.5;
      } else if (screenWidth < 600) {
        crossAxisCount = 2;
        aspectRatio = 0.75;
      } else if (screenWidth < 900) {
        crossAxisCount = 3;
        aspectRatio = 0.8;
      } else {
        crossAxisCount = 4;
        aspectRatio = 0.85;
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: aspectRatio,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final book = snapshot.data![index];
          return _buildBookCard(book.title, '฿${book.price}');
        },
      );
    },
  );
}
