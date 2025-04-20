import 'package:flutter/material.dart';
import 'package:secret_notes_v2/go.dart';
import 'package:secret_notes_v2/login.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/panner_ad.dart';
import 'package:secret_notes_v2/signup.dart';

String ntitle = "";
String ntext = "";

addnotesql() async {
  await sqlDp.insertData(
      "INSERT INTO 'notes' ('user','title','note') VALUES ('${usernamel}','${ntitle}','${ntext}') ");
}

class Addnotes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddnotesState();
  }
}

class AddnotesState extends State<Addnotes> with WidgetsBindingObserver {
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
      _exet1(context);
      gotime = DateTime.now();
    }
    if (isOnground) {
      backtime = DateTime.now();
      logoutifback(context);
    }
  }

  void toast1(BuildContext context) {}
  Future<bool> _exet1(BuildContext context) async {
    toast1(context);
    add();
    Navigator.of(context).pushReplacementNamed("temp");
    return true;
  }

  GlobalKey<FormState> addkey = new GlobalKey<FormState>();

  add() {
    var adddata = addkey.currentState;
    if (adddata!.validate()) {
      adddata.save();
      addnotesql();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "YOUR NOTE SUCCESSFULLY SAVED",
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
      onWillPop: () => _exet1(context),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                add();
                Navigator.of(context).pushReplacementNamed("temp");
              },
              icon: Icon(
                Icons.arrow_back,
                color: appcolortext,
              )),

          // iconTheme: IconThemeData(color: appcolortext),

          backgroundColor: appcolorT,
          title: Text(
            "ADD NOTE",
            style: TextStyle(color: appcolortext),
          ),
        ),
        body: Directionality(
          textDirection: al,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              color: appcolorback,
              padding: EdgeInsetsDirectional.all(20),
              child: Form(
                key: addkey,
                child: Column(
                  children: [
                    TextFormField(
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
                        labelText: "Note Title",
                        prefixIcon: Icon(
                          Icons.bookmark,
                          color: appcolora3,
                        ),
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
                      child: ListView(
                        children: [
                          Container(
                            padding: EdgeInsetsDirectional.all(2),
                            child: TextFormField(
                              maxLength: 2000,
                              maxLines: 8,
                              onSaved: (text) {
                                ntext = text!;
                              },
                              style: TextStyle(
                                  letterSpacing: 1.2, color: appcolora2),
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
                                    borderSide: BorderSide(
                                        width: 1.5, color: appcolora1)),
                                labelText: "Note",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 112, 137, 245)
                                                .withAlpha(50))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 168, 34, 0)
                                            .withAlpha(50))),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        width: 1.5, color: appcolora1)),
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
                  add();
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
