import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:secret_notes_v2/go.dart';
import 'package:secret_notes_v2/login.dart';
import 'package:secret_notes_v2/panner_ad.dart';
import 'package:secret_notes_v2/signup.dart';
import 'package:secret_notes_v2/u&p.dart';
import 'package:vocsy_esys_flutter_share/vocsy_esys_flutter_share.dart';

late String t;
late String tt;

late String snt;
late int i;
late var al;
late var al2;
late bool swit;
late var appcolorT;
late var appcolorT2;
late var appcolorT3;
late var appcolortext;
late var appcolortext2;
late var appcolortext3;
late var appcolortext4;
late var appcolortext5;

late var appcoloricon1;
late var appcolorcard;

late var appcolorback;
late var appcolordrower;
late var appcolora1;
late var appcolora2;
late var appcolora3;
late var appcolora4;

late bool swit2;
appcolor1() {
  if (swit2) {
    appcolorT = Color.fromARGB(255, 29, 41, 49);
    appcolorT2 = Color.fromARGB(255, 29, 41, 49);
    appcolorT3 = Color.fromARGB(255, 128, 48, 43);
    appcolortext = Color.fromARGB(255, 207, 207, 207);
    appcolortext2 = Color.fromARGB(255, 155, 155, 155);
    appcolortext3 = Color.fromARGB(255, 189, 189, 189);
    appcolortext4 = Color.fromARGB(255, 207, 207, 207);
    appcolortext5 = Color.fromARGB(255, 219, 219, 219);

    appcoloricon1 = Color.fromARGB(255, 31, 36, 39);
    appcolorcard = Color.fromARGB(255, 57, 68, 73);

    appcolorback = Color.fromARGB(255, 76, 85, 90);
    appcolordrower = Color.fromARGB(255, 76, 85, 90);
    appcolora1 = Color.fromARGB(255, 29, 41, 49);
    appcolora2 = Color.fromARGB(255, 207, 207, 207);
    appcolora3 = Color.fromARGB(255, 29, 41, 49);
    appcolora4 = Color.fromARGB(255, 29, 41, 49);
  } else {
    appcolorT = Colors.blue;
    appcolorT2 = Colors.white;
    appcolorT3 = Colors.red;
    appcolortext = Colors.white;
    appcolortext2 = Colors.black;
    appcolortext3 = Colors.white;
    appcolortext4 = Colors.blue;
    appcolortext5 = Colors.black;

    appcoloricon1 = Colors.blue;
    appcolorcard = Colors.grey[100];

    appcolorback = Colors.blueGrey[50];
    appcolordrower = Colors.blue;
    appcolora1 = Colors.blue;
    appcolora2 = Colors.black;
    appcolora3 = Colors.blue;
    appcolora4 = Colors.blue.withOpacity(.6);
  }
  return appcolorT;
}

class Notes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotesState();
  }
}

class NotesState extends State<Notes> with WidgetsBindingObserver {
  sdelete(indexn) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.blueGrey.withOpacity(.85),
            content: Text(
              "CLICK HERE TO DELETE THE Note",
              textAlign: TextAlign.center,
            ),
            contentTextStyle: TextStyle(color: Colors.white, fontSize: 17),
            actions: [
              Container(
                alignment: Alignment.center,
                child: IconButton(
                    iconSize: 37,
                    onPressed: () async {
                      {
                        int responsed = await sqlDp.deletetData(
                            "DELETE FROM 'notes' WHERE user = '${usernamel}'AND id ='${notes[indexn]["id"]}' ");
                        if (responsed > 0) {
                          notes.removeWhere((element) =>
                              element["id"] == notes[indexn]["id"]);
                          Navigator.of(context).pushReplacementNamed("temp");
                          setState(() {});
                        }
                      }
                    },
                    icon: Icon(Icons.delete)),
              )
            ],
          );
        }));
  }

  void toast3(
    BuildContext context,
  ) {}

  Future<bool> _exet3(BuildContext context) async {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.blueGrey.withOpacity(.85),
            content: Text(
              "CLICK HERE TO LOGOUT",
              textAlign: TextAlign.center,
            ),
            contentTextStyle: TextStyle(color: Colors.white, fontSize: 17),
            actions: [
              Container(
                alignment: Alignment.center,
                child: IconButton(
                    iconSize: 37,
                    onPressed: () async {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("go", (route) => false);
                    },
                    icon: Icon(Icons.logout)),
              )
            ],
          );
        }));

    return true;
  }

  late String s;
  late String s2;

  List notes = [];
  bool isloding = true;
  Future notesdata() async {
    List<Map> response = await sqlDp
        .readData("SELECT * FROM 'notes' WHERE user = '${usernamel}' ");
    notes.addAll(response);
    isloding = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    notesdata();
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
      gotime = DateTime.now();
    }
    if (isOnground) {
      backtime = DateTime.now();
      logoutifback(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exet3(context),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: appcolortext),
          backgroundColor: appcolor1(),
          title: Text(
            "MY NOTES",
            style: TextStyle(color: appcolortext),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: appcolordrower,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Text(
                        "${usernamel}",
                        style: TextStyle(
                            fontSize: 20,
                            color: appcolorT2,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Dark Mode     ",
                          style: TextStyle(color: appcolorT2, fontSize: 17),
                        ),
                        Switch(
                            inactiveThumbColor: appcolortext3,
                            activeColor: appcolorT2,
                            value: swit2,
                            onChanged: (value) {
                              if (value == true) {
                                swit2 = true;
                                appcolor1();
                                addlast();
                              } else {
                                swit2 = false;
                                appcolor1();
                                addlast();
                              }
                              setState(() {});

                              swit2 = value;
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Align to Right",
                          style: TextStyle(color: appcolorT2, fontSize: 17),
                        ),
                        Switch(
                            inactiveThumbColor: appcolortext3,
                            activeColor: appcolorT2,
                            value: swit,
                            onChanged: (value) {
                              if (value == true) {
                                al = TextDirection.rtl;
                                al2 = Alignment.bottomLeft;
                                swit = true;
                                addlast();
                              } else {
                                al = TextDirection.ltr;
                                al2 = Alignment.bottomRight;
                                swit = false;
                                addlast();
                              }
                              setState(() {});
                              swit = value;
                            }),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("changepass");
                        },
                        child: Text(
                          "Change Password",
                          style: TextStyle(color: appcolorT2, fontSize: 18),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("go");
                        },
                        child: Text(
                          "SIGN OUT",
                          style: TextStyle(color: appcolorT3, fontSize: 15),
                        )),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        body: Directionality(
          textDirection: al,
          child: Stack(children: [
            Container(
              color: appcolorback,
              padding: EdgeInsetsDirectional.only(bottom: 60),
              child: Stack(alignment: Alignment.topCenter, children: [
                ListView.builder(
                  padding: EdgeInsetsDirectional.only(top: 10, bottom: 10),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (("${notes[index]["note"]}").length < 19) {
                      s = "${notes[index]["note"]}";
                    } else {
                      s = "${(notes[index]["note"]).substring(0, 19)}" +
                          " ....";
                    }
                    if (("${notes[index]["title"]}").length < 17) {
                      s2 = "${notes[index]["title"]}";
                    } else {
                      s2 = "${(notes[index]["title"]).substring(0, 17)}" + "..";
                    }
                    return Card(
                      color: appcolorcard,
                      child: ListTile(
                        onTap: () {
                          t = "${notes[index]["title"]}";
                          snt = "${notes[index]["note"]}";
                          i = notes[index]["id"];
                          late String s3;
                          if (("${notes[index]["title"]}").length < 17) {
                            s3 = "${notes[index]["title"]}";
                          } else {
                            s3 = "${(notes[index]["title"]).substring(0, 17)}" +
                                "..";
                          }
                          tt = s3.replaceAll("\n", " ");
                          snt = "${notes[index]["note"]}";
                          i = notes[index]["id"];
                          Navigator.of(context).pushNamed("viewnote");
                        },
                        title: Text(
                          s2.replaceAll("\n", " "),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appcolortext5),
                        ),
                        subtitle: Text(
                          "   " + s.replaceAll("\n", " "),
                          style: TextStyle(color: appcolortext5),
                        ),
                        leading: Icon(
                          Icons.note,
                          color: appcoloricon1,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await sdelete(index);
                                },
                                icon: Icon(Icons.delete, color: appcoloricon1)),
                            IconButton(
                                onPressed: () async {
                                  t = "${notes[index]["title"]}";
                                  snt = "${notes[index]["note"]}";
                                  i = notes[index]["id"];
                                  var uu = DateTime.now();
                                  gotime = uu;
                                  VocsyShare.text("time $uu",
                                      " $uu \n \n $t \n \n $snt", "text/plain");
                                },
                                icon: Icon(Icons.share, color: appcoloricon1)),
                            IconButton(
                                onPressed: () {
                                  t = "${notes[index]["title"]}";
                                  snt = "${notes[index]["note"]}";
                                  i = notes[index]["id"];
                                  Navigator.of(context).pushNamed("editnote");
                                },
                                icon: Icon(Icons.edit, color: appcoloricon1)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  alignment: al2,
                  padding: EdgeInsetsDirectional.only(bottom: 20, end: 20),
                  child: FloatingActionButton(
                    backgroundColor: appcolorT,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("addnotes");
                    },
                    child: Icon(
                      Icons.add,
                      color: appcolortext,
                    ),
                  ),
                ),
              ]),
            ),
            Positioned(
              bottom: 0,
              child: Stack(children: [
                Container(
                  color: appcolor1(),
                  height: 60,
                  width: ((MediaQuery.of(context).size.width)),
                ),
                Positioned(
                  bottom: 0,
                  left: (((MediaQuery.of(context).size.width) - scc) / 2),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: const Adpanner(),
                  ),
                )
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
