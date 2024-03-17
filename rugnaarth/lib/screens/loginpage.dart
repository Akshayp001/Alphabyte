import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rugnaarth/Utils/decorations.dart';
import 'package:rugnaarth/services/firebaseAuthServices.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String role = "Patient";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  InputDecoration borderedTextFielddec = InputDecoration(
    alignLabelWithHint: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        role = _tabController.index == 0 ? "Patient" : "Doctor";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      body: Container(
        height: sheight,
        decoration: BoxDecoration(color: Colors.black87),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: sheight * 0.20),
              Image(
                image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/rugnaarth-cc2df.appspot.com/o/assetsForApp%2FElegant_and_Minimalist_Medical_Logo-removebg-preview.png?alt=media&token=d20d3ea8-bbe5-45f5-81de-6cbe6c9d3bd0',
                ),
                height: swidth * 0.45,
                width: swidth * 0.45,
              ),
              Text(
                "Rugnaarth",
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(42, 156, 201, 1),
                ),
              ),
              SizedBox(height: 20),
              TabBar(
                onTap: (value) {
                  role = value == 0 ? "Patient" : "Doctor";
                },
                controller: _tabController,
                tabs: [
                  Tab(text: 'Patient'),
                  Tab(text: 'Doctor'),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: TextField(
                  controller: emailController,
                  decoration: borderedTextFielddec.copyWith(
                    prefixIcon: Icon(FontAwesomeIcons.envelope),
                    prefixIconColor: Colors.red,
                    labelText: "Email",
                    hintText: "Enter Email",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: PasswordField(
                  controller: passwordController,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () => FirebaseAuthService().signUp(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            context,role),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  PasswordField({required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !showPassword,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(FontAwesomeIcons.key),
        prefixIconColor: Colors.red,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          child: Icon(
              showPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
        ),
        labelText: "Password",
        hintText: "Enter Password",
      ),
    );
  }
}
