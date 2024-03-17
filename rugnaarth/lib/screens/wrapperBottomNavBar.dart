import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rugnaarth/screens/Homepage.dart';
import 'package:rugnaarth/screens/PatientDocs.dart';
import 'package:rugnaarth/screens/userProfile.dart';

class BottomNavBarWrapper extends StatefulWidget {
  @override
  _BottomNavBarWrapperState createState() => _BottomNavBarWrapperState();
}

class _BottomNavBarWrapperState extends State<BottomNavBarWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    PatientDocs(),
    ProfilePage1(userName: '', userEmail: '', userPicUrl: ''),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.displayName.toString());
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: 'My Docs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
