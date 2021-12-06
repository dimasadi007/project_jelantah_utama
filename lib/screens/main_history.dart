import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
// import 'package:jelantah/screens/historis_item_selesai.dart';
import 'package:intl/intl.dart';
// import 'package:jelantah/screens/login_page.dart';
// import 'package:jelantah/screens/historis.dart';
// import 'package:jelantah/screens/chat_list.dart';
// import 'package:jelantah/screens/tutorial.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'login_screen.dart';
import 'main_history2_old.dart';

class Historis extends StatefulWidget {
  @override
  _HistorisState createState() => _HistorisState();
}

class _HistorisState extends State<Historis> {
  var orderid = ["123-456-789", "123-456-789", "123-456-789", "123-456-789"];
  var alamat = [
    "Jalan Cut Meutia No 1, Jakarta Barat, 11146",
    "Jalan Cut Meutia No 1, Jakarta Barat, 11146",
    "Jalan Cut Meutia No 1, Jakarta Barat, 11146",
    "Jalan Cut Meutia No 1, Jakarta Barat, 11146",
  ];
  var estimasi = [
    "Senin, 22 November 2021",
    "Senin, 22 November 2021",
    "Senin, 22 November 2021",
    "Senin, 22 November 2021",
  ];
  var status = [
    "Selesai",
    "Batal",
    "Proses",
    "Dalam Perjalanan",
  ];
  var volume = [
    "10",
    "10",
    "10",
    "10",
  ];

  late bool _hasMore;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _defaultPhotosPerPageCount = 15;
  //List<Photo> _photos;
  final int _nextPageThreshold = 5;

  var _token;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString("token");
    //setState(
    //  () {},
    //);
  }

  Future<void> fetchDataPickupOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString("token");
    try {
      Map bodi = {
        "token": _token,
        "status": ["pending", "process", "change_date"]
      };
      var body = jsonEncode(bodi);

      print("bodyy: " + body);
      final response = await http.post(
          Uri.parse(
              "http://10.0.2.2:8000/api/contributor/pickup_orders/get?page=$_pageNumber"),
          body: body);
      final data = jsonDecode(response.body);

      String status = data['status'];
      print("statusnnyaa: " + status);
      //String datanya = data['data'];
      //print("data: " + data);
      //String pickup_order_no = data['data']['pickup_order_no'];
      //print("pickup_order_no: " + pickup_order_no);

      // final response = await http.get(
      //     "https://jsonplaceholder.typicode.com/photos?_page=$_pageNumber");
      // List<Photo> fetchedPhotos = Photo.parseList(json.decode(response.body));
      // setState(() {
      //   _hasMore = fetchedPhotos.length == _defaultPhotosPerPageCount;
      //   _loading = false;
      //   _pageNumber = _pageNumber + 1;
      //   _photos.addAll(fetchedPhotos);
      // });
    } catch (e) {
      print("catchhhhh");
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getPref();
    _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;
    //_photos = [];

    print("statustttt ");

    fetchDataPickupOrder();
    print("statusqqqqooo");
  }

  int _selectedNavbar = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: kIsWeb ? 500.0 : double.infinity,
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
                title: Text(
                  "Riwayat",
                  style: TextStyle(
                    color: Colors.blue, // 3
                  ),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0),
            body: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                      color: Colors.white,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text("Semua"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color(0xffE7EEF4),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Selesai"),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Proses"),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Konfirmasi"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        showTrackOnHover: true,
                        isAlwaysShown: true,
                        child: ListView.builder(
                            itemCount: 20,
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  for (var i = 0; i < orderid.length; i++)
                                    RC_Historis(
                                      orderid: orderid[i],
                                      alamat: alamat[i],
                                      estimasi: estimasi[i],
                                      status: status[i],
                                      volume: volume[i],
                                      color: Colors.blue,
                                    )
                                  // RC_Historis(orderid: '123-456-333', alamat: 'Jalan Cut Meutia No 1, Jakarta Barat, 11146', estimasi: 'Senin, 1 Agustus 2021', status: 'Selesai', volume: '10', color: Colors.blue,),
                                  // RC_Historis(orderid: '123-456-111', alamat: 'Jalan Cut Meutia No 1, Jakarta Barat, 11146', estimasi: 'Senin, 1 Agustus 2021', status: 'Batal', volume: '10', color: Colors.red,),
                                  // RC_Historis(orderid: '123-456-333', alamat: 'Jalan Cut Meutia No 1, Jakarta Barat, 11146', estimasi: 'Senin, 1 Agustus 2021', status: 'Selesai', volume: '10', color: Colors.blue,),
                                  // RC_Historis(orderid: '123-456-333', alamat: 'Jalan Cut Meutia No 1, Jakarta Barat, 11146', estimasi: 'Senin, 1 Agustus 2021', status: 'Selesai', volume: '10', color: Colors.blue,),
                                ],
                              );
                            }),
                      ),
                    )
                  ],
                ),
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
                        pageBuilder: (c, a1, a2) => LoginPage(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 200),
                      ),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => Historis(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => //ChatList(),
                            MainHistory(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => //Tutorial(),
                            MainHistory(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 300),
                      ),
                    );
                    break;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RC_Historis extends StatelessWidget {
  RC_Historis(
      {required this.orderid,
      required this.alamat,
      required this.estimasi,
      required this.status,
      required this.volume,
      required this.color});

  String orderid, alamat, estimasi, status, volume;
  Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => Historis_Item_Selesai()));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID ' + orderid,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '21 November 2021',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Alamat',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                alamat,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Estimasi Penjemputan',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                estimasi,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Volume',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        volume + ' Liter',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (status == 'Selesai')
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Selesai",
                        style: TextStyle(color: Colors.green),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xffECF8ED),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                    ),
                  if (status == 'Batal')
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Batal",
                        style: TextStyle(color: Colors.red),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xffFBE8E8),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                    ),
                  if (status == 'Proses')
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Proses",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xffE7EEF4),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                    ),
                  if (status == 'Dalam Perjalanan')
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Dalam Perjalanan",
                        style: TextStyle(color: Colors.orange),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xffFEF5E8),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
