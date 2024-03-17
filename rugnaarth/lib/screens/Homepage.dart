import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rugnaarth/Models/UserModels.dart';
import 'package:rugnaarth/screens/AiBot.dart';
import 'package:rugnaarth/screens/userProfile.dart';
import 'package:rugnaarth/services/ApiServices.dart';
import 'package:rugnaarth/widgets/DoctorTile.dart';
import 'package:rugnaarth/widgets/searchbar.dart';

class HomePage extends StatelessWidget {
  // final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = new TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return AIBotChatScreen();
          },
        )),
        child: Center(
          child: Text(
            "AI",
            style:
                GoogleFonts.firaCode(fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome,",
                          maxLines: 1,
                          style: GoogleFonts.poppins(fontSize: 24),
                        ),
                        Text("Akshay Patil".toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage1(
                          userEmail: 'userEmail',
                          userName: 'userName',
                          userPicUrl: '');
                    },
                  )),
                  child: const CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 32,
                    // child: Icon(FontAwesomeIcons.user),
                    child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/rugnaarth-cc2df.appspot.com/o/assetsForApp%2Fpng-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black.png?alt=media&token=7c59315b-5c17-49b4-a7ce-7f215e61d354")),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomSearchBar(
                textController: _searchController,
                hintText: 'Search For Doctor'),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Top Doctors :",
                  style:
                      GoogleFonts.poppins(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<List<UserModel>>(
                  stream: ApiServices().getDoctors().asStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Center(child: Text("No Data"));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<UserModel> dataa = snapshot.data as List<UserModel>;
                    print('debug : ' + dataa.length.toString());
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: DoctorTile(
                            title: dataa[index].name,
                            subtitle: dataa[index].email, //'Surgeon',
                            comment: 'Top Surgeon From Pune India',
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
