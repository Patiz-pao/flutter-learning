import 'package:flutter/material.dart';
import 'package:flutter_learning/pages/home.dart';
import 'package:flutter_learning/pages/todolist.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Todo List App",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: const Color.fromARGB(255, 30, 58, 138), // น้ำเงินเข้ม
          secondary: const Color.fromARGB(255, 30, 58, 138), // น้ำเงินเข้ม
          surface: const Color.fromARGB(
            255,
            255,
            255,
            255,
          ), // พื้นหลังของวัสดุต่างๆ
          background: const Color(0xFFE0E7FF), // สีพื้นหลังของแอป (สีฟ้าสว่าง)
          error: const Color(0xFFB00020), // สีของข้อความหรือปุ่มผิดพลาด
          onPrimary: Colors.white, // สีของข้อความบนพื้นหลัง primary
          onSecondary: Colors.white, // สีของข้อความบนพื้นหลัง secondary
          onSurface: Colors.black, // สีของข้อความบนพื้นหลัง surface
          onBackground: Colors.black, // สีของข้อความบนพื้นหลัง background
          onError: Colors.white, // สีของข้อความบนพื้นหลัง error
        ),

        textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.kanit(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[const HomePage(), const TodoList()][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Badge(isLabelVisible: false, child: Icon(Icons.home)),
            icon: Badge(
              isLabelVisible: false,
              child: Icon(Icons.home_outlined),
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Badge(isLabelVisible: false, child: Icon(Icons.list)),
            icon: Badge(isLabelVisible: false, child: Icon(Icons.list)),
            label: 'Todo List',
          ),
        ],
      ),
    );
  }
}
