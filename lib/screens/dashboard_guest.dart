//import 'dart:html';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:project_jelantah_utama/models/responseVideo.dart';
import 'package:project_jelantah_utama/screens/main_history_semua.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:jelantah/screens/permintaan_penjemputan.dart';
// import 'package:jelantah/screens/user_baru.dart';
// import 'package:jelantah/screens/setting_data_master.dart';
// import 'package:jelantah/screens/account.dart';
// import 'package:jelantah/screens/login_page.dart';
// import 'package:jelantah/screens/historis.dart';
// import 'package:jelantah/screens/chat_list.dart';
// import 'package:jelantah/screens/tutorial.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:jelantah/screens/ubah_tutorial.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'account_screen.dart';
import 'chat_admin.dart';
import 'dashboard.dart';
import 'login_screen.dart';

class DashboardGuest extends StatefulWidget {
  // final VoidCallback signOut;
  //
  // Dashboard(this.signOut);

  @override
  _DashboardGuestState createState() => _DashboardGuestState();
}

enum LoginStatusDashboardGuest { notSignIn, signIn }

class _DashboardGuestState extends State<DashboardGuest> {
  LoginStatusDashboardGuest _loginStatus = LoginStatusDashboardGuest.notSignIn;

  // var url = [
  //   "https://www.youtube.com/watch?v=LvUYbxlSGHw",
  //   "https://www.youtube.com/watch?v=LvUYbxlSGHw",
  //   "https://www.youtube.com/watch?v=LvUYbxlSGHw"
  // ];
  //var idyoutube = ["LvUYbxlSGHw", "LvUYbxlSGHw", "LvUYbxlSGHw"];
  // var judul = [
  //   "Semua yang perlu kamu ketahui, Jelantah App",
  //   "judul2",
  //   "judul3"
  // ];
  //var deskripsi = ["youtube1", "youtube1", "youtube1"];
  //var tanggal = ["10 Oktober 2021", "10 Oktober 2021", "10 Oktober 2021"];
  var decodedData;
  var _token, _nama, _tokenSignout;

  var status, pesan;
  var balance, price;
  var userFirstname;

  var url, judul, idyoutube, deskripsi, tanggal;

  // String getVideoID(String url) {
  //   url = YoutubePlayer.convertUrlToId(url)!;
  //   // = url.replaceAll("https://www.youtube.com/watch?v=", "");
  //   //url = url.replaceAll("https://m.youtube.com/watch?v=", "");
  //   return url;
  // }

  // savePref(String status, String pesan, String token) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     preferences.setString("status", status);
  //     preferences.setString("pesan", pesan);
  //     preferences.setString("token", token);
  //     preferences.commit();
  //   });
  // }

  // getPref() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     status = preferences.getString("status");
  //     _token = (preferences.getString('token') ?? '');
  //
  //     _loginStatus =
  //         status == "success" ? LoginStatus.signIn : LoginStatus.notSignIn;
  //   });
  // }

  // signOut() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   _token = preferences.getString("token");
  //   print("tokennya: " + _token);
  //   Map bodi = {"token": _token};
  //   var body = jsonEncode(bodi);
  //   final response = await http.post(
  //       Uri.parse("http://10.0.2.2:8000/api/contributor/session/delete/"),
  //       body: body);
  //   final data = jsonDecode(response.body);
  //
  //   String status = data['status'];
  //   String pesan = data['message'];
  //
  //   if (status == "success") {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     setState(() {
  //       preferences.setString("status", null);
  //       preferences.setString("pesan", null);
  //       preferences.setString("token", null);
  //       _loginStatus = LoginStatus.notSignIn;
  //     });
  //     //print(pesan);
  //     //print(status);
  //   } else {
  //     showAlertDialog(context);
  //     //print(pesan);
  //     //print(status);
  //   }
  // }

  getDataDashboard() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // //_token = (preferences.getString('token') ?? '');
    // _token = preferences.getString("token");

    // Map bodi = {"token": _token};
    // var body = jsonEncode(bodi);
    Map bodiVideo = {"video_category_id": "1"};
    var bodyVideo = jsonEncode(bodiVideo);

    // final response = await http.post(
    //     Uri.parse("http://10.0.2.2:8000/api/contributor/dashboard/get"),
    //     body: body);
    // final data = jsonDecode(response.body);
    // final response2 = await http.post(
    //     Uri.parse("http://10.0.2.2:8000/api/contributor/user/get"),
    //     body: body);
    // final data2 = jsonDecode(response2.body);

    final responseVideo = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/contributor/videos/get"),
        body: bodyVideo);
    ResponseVideo dataVideo = responseVideoFromJson(responseVideo.body);

    if (mounted) {
      setState(() {
        // status = data['status'];
        // pesan = data['message'];
        // balance = data['balance'].toString();
        // price = data['price'].toString();
        // userFirstname = data2['user']["first_name"].toString();

        for (int i = 0; i < dataVideo.videos.length; i++) {
          url.add(dataVideo.videos[i].youtubeLink.toString());
          judul.add(dataVideo.videos[i].name.toString());
          deskripsi.add(dataVideo.videos[i].description.toString());
          //idyoutube.add(getVideoID(dataVideo.videos[i].youtubeLink.toString()));
          idyoutube.add(dataVideo.videos[i].youtubeLink.toString());
          String date = dataVideo.videos[i].updatedAt.toString();
          var dateTime = DateTime.parse(date);
          tanggal.add(
              DateFormat('dd MMMM yyyy', "id_ID").format(dateTime).toString());
        }
      });
    }

    // if (status == "success") {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // _token = (preferences.getString('token') ?? '');
    //   });
    //   print(pesan);
    //   print(status);
    // } else {
    //   showAlertDialog(context);
    //   print(pesan);
    //   print(status);
    // }
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        status = preferences.getString("status");
        _token = (preferences.getString('token') ?? '');

        _loginStatus = status == "success"
            ? LoginStatusDashboardGuest.signIn
            : LoginStatusDashboardGuest.notSignIn;
      });
    }
    getDataDashboard();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    url = [];
    judul = [];
    idyoutube = [];
    deskripsi = [];
    tanggal = [];
  }

  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatusDashboardGuest.notSignIn:
        return Center(
          child: Container(
            width: kIsWeb ? 500.0 : double.infinity,
            child: Scaffold(
              body: Container(
                color: Color(0xFFF9FBFF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hai,",
                                style: TextStyle(
                                  color: Colors.black, fontSize: 20, // 3
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Selamat datang di Jemput Jelantah App",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold // 3
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: Divider(color: Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.login_outlined,
                                size: 30.0,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Login atau Daftar',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RawMaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                                },
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 30.0,
                                  color: Colors.blue,
                                ),
                                padding: EdgeInsets.all(15.0),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(25, 5, 25, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Video',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        showTrackOnHover: true,
                        isAlwaysShown: true,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (var i = 0; i < url.length; i++)
                                RC_Video(
                                    url: url[i],
                                    idyoutube: idyoutube[i],
                                    judul: judul[i],
                                    deskripsi: deskripsi[i],
                                    tanggal: tanggal[i]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    title: Text('Beranda'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FlutterIcons.file_text_o_faw),
                    title: Text('Riwayat'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat_outlined),
                    title: Text('Pesan'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    title: Text('Profil'),
                  ),
                ],
                currentIndex: _selectedNavbar,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.blueGrey,
                showUnselectedLabels: true,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) => DashboardGuest(),
                          transitionsBuilder: (c, anim, a2, child) =>
                              FadeTransition(opacity: anim, child: child),
                          transitionDuration: Duration(milliseconds: 200),
                        ),
                      );
                      break;
                    case 1:
                      showAlertDialog(context);
                      break;
                    case 2:
                      showAlertDialog(context);
                      break;
                    case 3:
                      showAlertDialog(context);
                      break;
                  }
                },
              ),
            ),
          ),
        );

      case LoginStatusDashboardGuest.signIn:
        return Dashboard();
    }
  }

  void showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: Text("Ya"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Mode Guest"),
      content: Text("Harap Login terlebih dahulu untuk mengakses menu ini."),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class RC_Video extends StatelessWidget {
  RC_Video(
      {required this.url,
      required this.idyoutube,
      required this.judul,
      required this.deskripsi,
      required this.tanggal});

  String url, idyoutube, judul, deskripsi, tanggal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var urllaunchable = await canLaunch("https://www.youtube.com/watch?v=" +
            url); //canLaunch is from url_launcher package
        if (urllaunchable) {
          await launch("https://www.youtube.com/watch?v=" +
              url); //launch is from url_launcher package to launch URL
        } else {
          print("URL can't be launched.");
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://img.youtube.com/vi/$idyoutube/0.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tanggal,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: 230,
                  child: Row(
                    children: [
                      Flexible(
                        child: new Text(
                          judul,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
