import 'package:flutter/material.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/signup.dart';
import 'package:secret_notes_v2/u&p.dart';
import 'package:secret_notes_v2/login.dart';

List tswit = [0];
List tswit2 = [0];
List tcheck = [0];
List<String> tpass = [""];

DateTime backtime = DateTime.now();
DateTime gotime = DateTime.now();

logoutifback(context) {
  if (backtime.difference(gotime) > Duration(seconds: 120)) {
    Navigator.of(context).pushNamedAndRemoveUntil("go", (route) => false);
  }
}

class Go extends StatefulWidget {
  @override
  State<Go> createState() {
    return GoState();
  }
}

class GoState extends State<Go> {
  bool isloding = true;

  // del() async {
  //   await sqlDp.ondelete();
  // }

  Future redlast() async {
    List<Map> responsel =
        await sqlDp.readData("SELECT lastuser FROM lastusers");

    List<Map> responseswit = await sqlDp.readData("SELECT swit FROM lastusers");
    List<Map> responsedaeck =
        await sqlDp.readData("SELECT darck FROM lastusers");
    List<Map> responsecheck =
        await sqlDp.readData("SELECT checko FROM lastusers");
    List<Map> responsepass =
        await sqlDp.readData("SELECT lpassword FROM lastusers");

    responsel.forEach((element) {
      y.add(element["lastuser"]);
    });
    lastuser = y.last.toString();

    responseswit.forEach((element) {
      tswit.add(element["swit"]);
    });
    // print(tswit.last);
    swit = (tswit.last == 1) ? true : false;
    // print(swit);
    if (swit == false) {
      al = TextDirection.ltr;
      al2 = Alignment.bottomRight;
    } else {
      al = TextDirection.rtl;
      al2 = Alignment.bottomLeft;
    }

    responsedaeck.forEach((element) {
      tswit2.add(element["darck"]);
    });
    // print(tswit.last);
    swit2 = (tswit2.last == 1) ? true : false;
    // print(swit2);

    if (swit2 == false) {
      // forrunswit2() {
      //  return swit2;
      // }
      appcolor1();
    } else {
      // forrunswit2() {
      //   return swit2;
      // }
      appcolor1();
    }

    responsecheck.forEach((element) {
      tcheck.add(element["checko"]);
    });
    // print(responsecheck);
    // print(tcheck.last);
    responsepass.forEach((element) {
      tpass.add(element["lpassword"]);
    });

    check = (tcheck.last == 1) ? true : false;
    // print(check);

    if (check == false) {
      lastpassword = "";
      // appcolor1();
    } else {
      lastpassword = tpass.last;
      // appcolor1();
    }

    // responsepass.forEach((element) {
    //   tcheck.add(element["password"]);
    // });
    // if (check) password = tpass.last;

    // if (check == false) {
    //   appcolor1();
    // } else {
    //   appcolor1();
    // }

    isloding == false;
    setState(() {});
    // print("${tpass.last}" +
    // "++++++++++++++++++++++++++++++++++++++++\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    Navigator.of(context).pushReplacementNamed("login");
  }

  @override
  void initState() {
    // del();
    redlast();
    userlist();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 232, 234, 236),
      child: Center(
          child: Container(
              height: 50, width: 50, child: CircularProgressIndicator())),
    );
  }
}
