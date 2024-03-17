import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rugnaarth/screens/Homepage.dart';
import 'package:rugnaarth/screens/PatientDocs.dart';
import 'package:rugnaarth/screens/loginpage.dart';
import 'package:rugnaarth/screens/userProfile.dart';
import 'package:rugnaarth/screens/wrapperBottomNavBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(background: Colors.deepPurple.shade900),
        useMaterial3: true,
      ),
      // home: PatientDocs(),
      // home: HomePage(),
      // home: ProfilePage1(
      //     userEmail: "App9823696@gmail.com",
      //     userName: "Akshay Patil",
      //     userPicUrl: ""),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return LoginPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return BottomNavBarWrapper();
        },
      ),
    );
  }
}
