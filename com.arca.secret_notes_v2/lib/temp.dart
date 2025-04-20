import 'package:flutter/material.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/signup.dart';
import 'package:secret_notes_v2/u&p.dart';
import 'package:secret_notes_v2/login.dart';

class Temp extends StatefulWidget {
  @override
  State<Temp> createState() {
    return TempState();
  }
}

class TempState extends State<Temp> {
  bool load = true;
  Future tempgo() async {
    List<Map> temp = await sqlDp.readData("SELECT lastuser FROM lastusers");
    setState(() {});
    load = false;
    // Navigator.of(context).pushReplacementNamed("notes");
    Navigator.of(context).pushNamedAndRemoveUntil("notes", (route) => false);
  }

  @override
  void initState() {
    tempgo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appcolorback,
      child: Center(
          child: Container(
              height: 50, width: 50, child: CircularProgressIndicator())),
    );
  }
}
