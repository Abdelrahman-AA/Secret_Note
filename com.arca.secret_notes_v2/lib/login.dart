import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secret_notes_v2/go.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/u&p.dart';

var usernamel;
var password;
String? lastuser;
String? lastpassword;
late bool check = false;

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  GlobalKey<FormState> fkey = new GlobalKey<FormState>();

  login() {
    var fdata = fkey.currentState;
    if (fdata!.validate()) {
      fdata.save();

      if (x["$usernamel"].toString() == password.toString()) {
        addlast();
        Navigator.of(context).pushReplacementNamed("notes");
      } else {
        return showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Colors.blueGrey.withOpacity(.85),
                content: Text(
                  "Please ckeck User name and Password\n\nIf you don't have account\nClick on Sign UP",
                  textAlign: TextAlign.center,
                ),
                contentTextStyle: TextStyle(color: Colors.white, fontSize: 17),
              );
            }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appcolorback,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blueGrey.withOpacity(.05),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          child: Form(
            key: fkey,
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: 200,
                  child: Image(
                    image: AssetImage("images/1.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                TextFormField(
                  initialValue: "$lastuser",
                  // onTap: () {
                  //   userlist();
                  // },
                  onSaved: (text) {
                    usernamel = text;
                  },
                  style: TextStyle(letterSpacing: 1.2),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (text) {
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.07),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(width: 1.5, color: appcolora1)),
                    labelText: "User Name",
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
                            color:
                                Color.fromARGB(255, 168, 34, 0).withAlpha(50))),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                TextFormField(
                  initialValue: "$lastpassword",
                  onSaved: (text) {
                    password = text;
                  },
                  style: TextStyle(letterSpacing: 1.2),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (text) {
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.07),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(width: 1.5, color: appcolora1)),
                    labelText: "Password",
                    prefixIcon: Icon(Icons.key),
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
                            color:
                                Color.fromARGB(255, 168, 34, 0).withAlpha(50))),
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        activeColor: appcolorT,
                        checkColor: appcolortext,
                        value: check,
                        onChanged: (val) {
                          setState(() {
                            check = val!;
                          });
                        }),
                    Text(
                      "   Remember my password          ",
                      style: TextStyle(color: appcolortext5),
                    )
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(150, 50), backgroundColor: appcolora4),
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      "LOGIN",
                      textScaleFactor: 1.7,
                      style: TextStyle(color: appcolortext),
                    )),
                // SizedBox(
                //   height: 20,
                // ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("signup");
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: appcolortext4),
                    )),
                Row(
                  children: [
                    Container(
                        height: 30,
                        width: 30,
                        child: Image(image: AssetImage("images/3.png"))),
                    Text(
                      "ARCA software",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
