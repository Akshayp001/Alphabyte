import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rugnaarth/Models/UserModels.dart';
import 'package:rugnaarth/services/ApiServices.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(
      String email, String password, BuildContext context, String role) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.additionalUserInfo!.isNewUser ||
          userCredential.additionalUserInfo!.username == null) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String name = '';
            String age = '';
            String gender = '';
            String bloodGroup = '';

            return Dialog(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Name'),
                        onChanged: (value) => name = value,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Age'),
                        onChanged: (value) => age = value,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Gender'),
                        onChanged: (value) => gender = value,
                      ),
                      // TextField(
                      //   decoration:
                      //       InputDecoration(labelText: 'Blood Group'),
                      //   onChanged: (value) => bloodGroup = value,
                      // ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              signOut();
                            },
                            child: Text('Cancel'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              if (role == 'Doctor') {
                                ApiServices().createDoctor(UserModel(
                                    name: name,
                                    type: role,
                                    email: email,
                                    id: '',
                                    age: age,
                                    gender: gender));
                              } else {
                                ApiServices().createPatient(UserModel(
                                    name: name,
                                    type: role,
                                    email: email,
                                    id: '',
                                    age: age,
                                    gender: gender));
                              }
                              FirebaseAuth.instance.currentUser!
                                  .updateDisplayName(name)
                                  .then((value) => Navigator.of(context).pop());
                            },
                            child: Text('Done'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }

      return userCredential.user;
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        return await login(email, password).then((value) {
          if (value!.displayName == null || value.displayName == '') {
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (BuildContext context) {
                String name = '';
                String age = '';
                String gender = '';
                String bloodGroup = '';

                return Dialog(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: 'Name'),
                            onChanged: (value) => name = value,
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Age'),
                            onChanged: (value) => age = value,
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Gender'),
                            onChanged: (value) => gender = value,
                          ),
                          // TextField(
                          //   decoration:
                          //       InputDecoration(labelText: 'Blood Group'),
                          //   onChanged: (value) => bloodGroup = value,
                          // ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  signOut();
                                },
                                child: Text('Cancel'),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (role == 'Doctor') {
                                    ApiServices().createDoctor(UserModel(
                                        name: name,
                                        type: role,
                                        email: email,
                                        id: '',
                                        age: age,
                                        gender: gender));
                                  } else {
                                    ApiServices().createPatient(UserModel(
                                        name: name,
                                        type: role,
                                        email: email,
                                        id: '',
                                        age: age,
                                        gender: gender));
                                  }
                                  FirebaseAuth.instance.currentUser!
                                      .updateDisplayName(name)
                                      .then((value) =>
                                          Navigator.of(context).pop());
                                },
                                child: Text('Done'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
      }
      print("Error during sign up: $e");
      return null;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error during sign out: $e");
    }
  }
}
