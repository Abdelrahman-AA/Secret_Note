import 'package:flutter/material.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/sqldp.dart';
import 'package:secret_notes_v2/u&p.dart';

var username;
var password1;
var password2;
SqlDb sqlDp = SqlDb();

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  TextEditingController userin = new TextEditingController();
  TextEditingController password = new TextEditingController();
  GlobalKey<FormState> fkey = new GlobalKey<FormState>();
  signup() async {
    var fdata = fkey.currentState;
    if (fdata!.validate()) {
      fdata.save();

      int response = await sqlDp.insertData(
          "INSERT INTO 'users' ('user','password') VALUES ('${username}','${password1}')");

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
                  "User name shold between 6 - 16\nPassword should between 8 - 20\n\n!! Make sure password are match in two fields"),
              contentTextStyle: TextStyle(color: Colors.white, fontSize: 17),
            );
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolorback,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(25),
          child: Form(
            key: fkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  child: Image(
                    image: AssetImage("images/1.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                TextFormField(
                  controller: userin,
                  onSaved: (text) {
                    username = text;
                  },
                  style: TextStyle(letterSpacing: 1.2, color: appcolora2),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (text) {
                    if (text!.length < 6 || text.length > 16) {
                      return "Should between 6 - 16";
                    } else if (x.containsKey(userin.text)) {
                      return "This user name is taken";
                    } else {
                      return null;
                    }
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
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (text) {
                    password1 = text;
                  },
                  style: TextStyle(letterSpacing: 1.2, color: appcolora2),
                  controller: password,
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
                        borderSide: BorderSide(width: 1.5, color: appcolora1)),
                    labelText: "Password",
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
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (text) {
                    password2 = text;
                  },
                  style: TextStyle(letterSpacing: 1.2, color: appcolora2),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (text) {
                    if (text!.length < 8 || text.length > 20) {
                      return "Should between 8 - 20";
                    } else if (text != password.text) {
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
                        borderSide: BorderSide(width: 1.5, color: appcolora1)),
                    labelText: "Repeat Password",
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
                SizedBox(
                  height: 60,
                ),
                // TextButton(
                //     onPressed: () async {
                //       await sqlDp.ondelete();
                //     },
                //     child: Text(
                //       "delete",
                //       style: TextStyle(fontSize: 20),
                //     )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(150, 50), backgroundColor: appcolora4),
                    onPressed: () {
                      signup();
                    },
                    child: Text(
                      "SIGN UP",
                      textScaleFactor: 1.7,
                      style: TextStyle(color: appcolortext),
                    )),
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If you have account",
                      style: TextStyle(fontSize: 20, color: appcolortext5),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("login");
                        },
                        child: Text(
                          "CLICK HERE",
                          style: TextStyle(fontSize: 20, color: appcolortext4),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
