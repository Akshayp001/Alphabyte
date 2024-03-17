import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rugnaarth/services/firebaseAuthServices.dart';

class ProfilePage1 extends StatelessWidget {
  final String userEmail;
  final String userName;
  final String userPicUrl;

  ProfilePage1({
    required this.userEmail,
    required this.userName,
    required this.userPicUrl,
  });

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuthService().signOut().then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Container(
                        decoration: BoxDecoration(
                            color: Colors.amber.shade200,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black12),
                            boxShadow: [BoxShadow()]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: hight * 0.02,
                          ),
                          child: const Center(
                            child: Text(
                              "Logged Out Successfully..",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                        ),
                      ),
                    )));
              },
              icon: FaIcon(FontAwesomeIcons.powerOff))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: _TopPortion(
                url:
                    'https://firebasestorage.googleapis.com/v0/b/rugnaarth-cc2df.appspot.com/o/assetsForApp%2Fpng-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black.png?alt=media&token=7c59315b-5c17-49b4-a7ce-7f215e61d354',
              )),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    indent: width * 0.25,
                    endIndent: width * 0.25,
                    color: Colors.cyan.shade200,
                    thickness: 0.5,
                  ),
                  Text(
                    "Patient",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: width * 0.05),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'follow',
                        elevation: 0,
                        label: const Text("Follow"),
                        icon: const Icon(FontAwesomeIcons.person),
                      ),
                      const SizedBox(width: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'mesage',
                        elevation: 0,
                        backgroundColor: Colors.green,
                        label: const Text("Contact"),
                        icon: const Icon(FontAwesomeIcons.phone),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // BIO COntainer
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: hight * 0.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Rubik",
                              fontSize: width * 0.05),
                        ),
                        Text("Write something about you..")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatelessWidget {
  final String url;
  const _TopPortion({required this.url, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(url)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
