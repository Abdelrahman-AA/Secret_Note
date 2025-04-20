import 'package:flutter/material.dart';
import 'package:secret_notes_v2/go.dart';
import 'package:secret_notes_v2/login.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/panner_ad.dart';
import 'package:secret_notes_v2/signup.dart';

String ntitle = "";
String ntext = "";

editnotesql() async {
  await sqlDp.insertData(
      "UPDATE 'notes' SET 'title' = '${ntitle}', 'note' = '${ntext}' WHERE user = '${usernamel}'AND id = ${i} ");
}

class Editnotes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditnotesState();
  }
}

class EditnotesState extends State<Editnotes> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;
    final isOnground = state == AppLifecycleState.resumed;

    if (isBackground) {
      _exet2(context);
      gotime = DateTime.now();
    }
    if (isOnground) {
      backtime = DateTime.now();
      if (backtime.difference(gotime) > Duration(seconds: 120)) {
        editnote();
      }
      ;
      logoutifback(context);
    }
  }

  void toast2(
    BuildContext context,
  ) {}

  Future<bool> _exet2(BuildContext context) async {
    toast2(context);

    editnote();
    Navigator.of(context).pushReplacementNamed("temp");
    return true;
  }

  GlobalKey<FormState> addkey = new GlobalKey<FormState>();

  editnote() {
    var adddata = addkey.currentState;
    if (adddata!.validate()) {
      adddata.save();
      editnotesql();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "YOUR NOTE EDITED SUCCESSFULLY",
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ));
      Navigator.of(context).pushReplacementNamed("temp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exet2(context),
      child: Scaffold(
        backgroundColor: appcolorback,
        appBar: AppBar(
          backgroundColor: appcolorT,
          title: Text("EDIT NOTE  ( ${t} )"),
        ),
        body: Directionality(
          textDirection: al,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              padding: EdgeInsetsDirectional.all(20),
              child: Form(
                key: addkey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: t,
                      maxLength: 20,
                      onSaved: (text) {
                        ntitle = text!;
                      },
                      style: TextStyle(letterSpacing: 1.2, color: appcolora2),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (text) {
                        if (text!.length == 0) {
                          return "Should input a Title";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(.07),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1.5, color: appcolora1)),
                        labelText: "Edit Note Title",
                        prefixIcon: Icon(Icons.bookmark),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(255, 112, 137, 245)
                                    .withAlpha(50))),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: Color.fromARGB(255, 168, 34, 0)
                                    .withAlpha(50))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide(width: 1.5, color: appcolora1)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      child: TextFormField(
                        initialValue: snt,
                        maxLength: 500,
                        maxLines: 8,
                        onSaved: (text) {
                          ntext = text!;
                        },
                        style: TextStyle(letterSpacing: 1.2, color: appcolora2),
                        autovalidateMode: AutovalidateMode.always,
                        validator: (text) {
                          if (text!.length == 0) {
                            return "Should input a Note";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withOpacity(.07),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(width: 1.5, color: appcolora1)),
                          labelText: "Edit Note",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 112, 137, 245)
                                      .withAlpha(50))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 168, 34, 0)
                                      .withAlpha(50))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(width: 1.5, color: appcolora1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                color: appcolorT,
                height: 60,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: const Adpanner(),
              )
            ]),
            Container(
              alignment: al2,
              padding: EdgeInsetsDirectional.only(bottom: 80, end: 20),
              child: FloatingActionButton(
                backgroundColor: appcolorT,
                onPressed: () {
                  editnote();
                },
                child: Icon(
                  Icons.done,
                  color: appcolortext,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
