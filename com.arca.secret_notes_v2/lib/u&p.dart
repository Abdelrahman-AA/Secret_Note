import 'package:secret_notes_v2/login.dart';
import 'package:secret_notes_v2/notes.dart';
import 'package:secret_notes_v2/signup.dart';

Map x = {};
userlist() async {
  List<Map> responsex = await sqlDp.readData("SELECT * FROM users");
  responsex.forEach((element) {
    x.addAll({element["user"]: element["password"]});
  });
}

ift() {
  int tt;
  if (swit == false) {
    tt = 0;
  } else {
    tt = 1;
  }
  return tt;
}

ift2() {
  int ttt;
  if (swit2 == false) {
    ttt = 0;
  } else {
    ttt = 1;
  }
  return ttt;
}

ift3() {
  int ch_s;
  if (check == false) {
    ch_s = 0;
  } else {
    ch_s = 1;
  }
  return ch_s;
}

ift4() {
  String pass;
  if (check == false) {
    pass = "${password}";
  } else {
    pass = "${password}";
  }
  return pass;
}

List y = [""];
addlast() async {
  await sqlDp.insertData(
      "INSERT INTO 'lastusers' ('lastuser','swit','darck','checko','lpassword') VALUES ('${usernamel}',${ift()},${ift2()},${ift3()},'${ift4()}') ");
}
