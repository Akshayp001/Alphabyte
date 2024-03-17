import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rugnaarth/widgets/docListTile.dart';

class PatientDocs extends StatelessWidget {
  const PatientDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Docs"),
        centerTitle: true,
      ),
      body: Expanded(
          child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: ExListTile('1'),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: Icon(FontAwesomeIcons.plus)),
    );
  }
}
