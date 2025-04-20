import 'package:flutter/material.dart';
import 'package:secret_notes_v2/go.dart';
import 'package:secret_notes_v2/login.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/panner_ad.dart';
import 'package:secret_notes_v2/signup.dart';
import 'package:vocsy_esys_flutter_share/vocsy_esys_flutter_share.dart';

class Viewnotes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ViewnotesState();
  }
}

class ViewnotesState extends State<Viewnotes> with WidgetsBindingObserver {
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
      gotime = DateTime.now();
    }
    if (isOnground) {
      backtime = DateTime.now();
      logoutifback(context);
    }
  }

  sdelete2() {
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
                      await sqlDp.deletetData(
                          "DELETE FROM 'notes' WHERE user = '${usernamel}'AND id = ${i} ");
                      Navigator.of(context).pushReplacementNamed("temp");
                    },
                    icon: Icon(Icons.delete)),
              )
            ],
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolorback,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                var u = DateTime.now();
                gotime = u;
                VocsyShare.text("time $u", "$t \n \n $snt", "text/plain");
              },
              icon: Icon(Icons.share)),
        ],
        iconTheme: IconThemeData(color: appcolortext),
        backgroundColor: appcolorT,
        title: Row(
          children: [
            Icon(
              Icons.bookmark,
              color: appcolortext,
            ),
            Text(
              "   ${tt} ",
              style: TextStyle(color: appcolortext),
            ),
          ],
        ),
      ),
      body: Directionality(
        textDirection: al,
        child: Stack(alignment: Alignment.bottomCenter, children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: appcolorT,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: appcolorcard,
            ),
            margin: EdgeInsetsDirectional.only(
                top: 20, bottom: 170, end: 20, start: 20),
            padding: EdgeInsetsDirectional.all(10),
            child: ListView(
              children: [
                Text(
                  snt,
                  style: TextStyle(
                    letterSpacing: 1.2,
                    color: appcolortext5,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsetsDirectional.all(20),
          //   child: Form(
          //     child: Column(
          //       children: [

          //         // TextFormField(
          //         //   initialValue: snt,
          //         //   maxLines: 26,
          //         //   style: TextStyle(letterSpacing: 1.2, color: appcolortext5),
          //         //   decoration: InputDecoration(
          //         //     filled: true,
          //         //     fillColor: Colors.grey.withOpacity(.07),
          //         //     labelText: "Note",
          //         //     enabled: false,
          //         //     disabledBorder: OutlineInputBorder(
          //         //         borderRadius: BorderRadius.circular(5),
          //         //         borderSide: BorderSide(
          //         //             width: 1.5,
          //         //             color: Color.fromARGB(255, 112, 137, 245)
          //         //                 .withAlpha(50))),
          //         //   ),
          //         // ),
          //       ],
          //     ),
          //   ),
          // ),
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
            alignment: Alignment.bottomRight,
            padding: EdgeInsetsDirectional.only(bottom: 80, end: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  backgroundColor: appcolorT,
                  heroTag: "button1",
                  onPressed: () {
                    sdelete2();
                  },
                  child: Icon(
                    Icons.delete,
                    color: appcolortext,
                    size: 30,
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: appcolorT,
                  heroTag: "button2",
                  onPressed: () {
                    Navigator.of(context).pushNamed("editnote");
                  },
                  child: Icon(
                    Icons.edit,
                    color: appcolortext,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
