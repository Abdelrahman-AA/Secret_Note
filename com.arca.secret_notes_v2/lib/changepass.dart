import 'package:flutter/material.dart';
import 'package:secret_notes_v2/go.dart';
import 'package:secret_notes_v2/login.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/sqldp.dart';
import 'package:secret_notes_v2/u&p.dart';

var newpassword1;
var newpassword2;
SqlDb sqlDp = SqlDb();

class Changepass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChangepassState();
  }
}

class ChangepassState extends State<Changepass>with WidgetsBindingObserver {

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
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);
    if (state==AppLifecycleState.inactive||
        state==AppLifecycleState.detached)return;

    final isBackground =state == AppLifecycleState.paused;
    final isOnground =state == AppLifecycleState.resumed;

    if (isBackground){
      gotime = DateTime.now();
    }
    if (isOnground){
      backtime = DateTime.now();
      logoutifback(context);
    }
  }

  TextEditingController newpassword = new TextEditingController();
  GlobalKey<FormState> fkey = new GlobalKey<FormState>();
  changepass() async {
    var fdata = fkey.currentState;
    if (fdata!.validate()) {
      fdata.save();
      await sqlDp.insertData(
          "UPDATE 'users' SET 'password' = '${newpassword1}' WHERE user = '${usernamel}'");
      Navigator.of(context).pushReplacementNamed("go");
    } else {
      return showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.blueGrey.withOpacity(.85),
              content: Text(
                  "Password should between 8 - 20\n\n!! Make sure password are match in two fields"),
              contentTextStyle: TextStyle(color: Colors.white, fontSize: 17),
            );
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolorback,
      appBar: AppBar(
        backgroundColor: appcolorT,
        title: Text("Change Password"),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(25),
          child: Form(
            key: fkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (text) {
                    newpassword1 = text;
                  },
                  style: TextStyle(letterSpacing: 1.2, color: appcolora2),
                  controller: newpassword,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (text) {
                    if (text!.length < 8 || text.length > 20) {
                      return "Should between 8 - 20";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.07),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Color.fromARGB(255, 112, 137, 245))),
                    labelText: "New Password",
                    prefixIcon: Icon(Icons.person),
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
                            color: Color.fromARGB(255, 112, 137, 245)
                                .withAlpha(50))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (text) {
                    newpassword2 = text;
                  },
                  style: TextStyle(letterSpacing: 1.2, color: appcolora2),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (text) {
                    if (text!.length < 8 || text.length > 20) {
                      return "Should between 8 - 20";
                    } else if (text != newpassword.text) {
                      return "Password  not  match";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.07),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Color.fromARGB(255, 112, 137, 245))),
                    labelText: "Repeat New Password",
                    prefixIcon: Icon(Icons.person),
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
                            color: Color.fromARGB(255, 112, 137, 245)
                                .withAlpha(50))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(250, 50), backgroundColor: appcolora4),
                    onPressed: () {
                      changepass();
                    },
                    child: Text(
                      "Change Password",
                      textScaleFactor: 1.7,
                      style: TextStyle(color: appcolortext),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
