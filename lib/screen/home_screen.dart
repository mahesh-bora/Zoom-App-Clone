import 'package:flutter/material.dart';
import 'package:zoom_app_clone/resources/auth_methods.dart';
import 'package:zoom_app_clone/screen/history_meeting_screen.dart';
import 'package:zoom_app_clone/utils/color.dart';
import 'package:zoom_app_clone/widgets/custom_button.dart';

import 'meeting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [
    MeetingScreen(),
    HistoryMeetingScreen(),
    const Text('Contacts'),
    CustomButton(text: "Log Out!", onPressed: () => AuthMethods().signOut()),
  ];

  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Meet & Chat'),
        centerTitle: true,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.comment_bank), label: 'Meet & Char'),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Meetings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined), label: 'Contacts'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
