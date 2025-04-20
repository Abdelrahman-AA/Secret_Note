import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:secret_notes_v2/addnote.dart';
import 'package:secret_notes_v2/changepass.dart';
import 'package:secret_notes_v2/editnote.dart';
import 'package:secret_notes_v2/go.dart';
import 'package:secret_notes_v2/login.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/signup.dart';
import 'package:secret_notes_v2/temp.dart';
import 'package:secret_notes_v2/viewnote.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());



}
class MyApp extends StatelessWidget{
  Widget build(BuildContext context) {
  return MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Go(),
  routes: {
  "login": (context) => Login(),
  "signup": (context) => Signup(),
  "notes": (context) => Notes(),
  "addnotes": (context) => Addnotes(),
  "editnote": (context) => Editnotes(),
  "viewnote": (context) => Viewnotes(),
  "changepass": (context) => Changepass(),
  "go": (context) => Go(),
  "temp": (context) => Temp(),
  },
  );
}
}
