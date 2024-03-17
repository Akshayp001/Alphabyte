import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AIBotChatScreen extends StatelessWidget {
  const AIBotChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _textEditingController = new TextEditingController();
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'ChatBot : Rugnaarthi',
            style: GoogleFonts.telex(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(

              //     gradient: LinearGradient(colors: [
              //   // Colors.red.withOpacity(0.15),
              //   // Colors.pink.withOpacity(0.15),
              //   // Colors.purple.withOpacity(0.15),
              // ])),
              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Feature is ready and will be Available Soon In Application : For more details contact Administrator',
                textAlign: TextAlign.center,
                style: GoogleFonts.telex(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 240,
              ),
              Row(children: [
                Flexible(
                  flex: 5,
                  child: RoundedSearchInput(
                      textController: _textEditingController,
                      hintText: 'Type Something..'),
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.paperPlane)),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}

class RoundedSearchInput extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  const RoundedSearchInput(
      {required this.textController, required this.hintText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: textController,
        enabled: false,
        onChanged: (value) {
          //Do something wi
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[500]!,
          ),
          filled: true,
          fillColor: Colors.white12,
          hintText: hintText,
          hintStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
          ),
        ),
      ),
    );
  }
}
