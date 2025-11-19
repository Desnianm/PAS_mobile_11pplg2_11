import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'tvshow_page.dart';
import 'bookmark_page.dart';
import 'profile_page.dart';
import '../controller/tvshow_controller.dart';
import '../controller/bookmark_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int idx = 0;
  final pages = [const TvshowPage(), const BookmarkPage(),  ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        onTap: (v) => setState(() => idx = v),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv_outlined), label: 'TVshow'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
