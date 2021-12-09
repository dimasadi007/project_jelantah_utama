import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:project_jelantah_utama/models/responseAddress.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'main_history.dart';

class JadwalkanPenjemputan extends StatefulWidget {
  @override
  _JadwalkanPenjemputanState createState() => _JadwalkanPenjemputanState();
}

class _JadwalkanPenjemputanState extends State<JadwalkanPenjemputan> {
  late String email, password, confirm_password, nama;
  // late String nama_depan,
  //     nama_belakang,
  //     kode_pos,
  //     alamat,
  //     nomor_telepon,
  //     nama_penerima,
  //     nomor_telepon_penerima;
  int price = 4000;
  int city = 268;

  late bool _loading;
  final _key = new GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  var confirmPass;

  bool _secureText = true;

  var _token, status, pesan, status2, pesan2;
  var id_alamat,
      alamat,
      kota,
      kode_pos,
      nama_penerima,
      no_telepon_penerima,
      volume_pasokan;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  setPenjadwalanPenjemputan() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      send();
    }
  }

  send() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //_token = (preferences.getString('token') ?? '');
    _token = preferences.getString("token");
    Map bodi = {
      "token": _token,
      "address_id": id_alamat[0],
      "estimate_volume": volume_pasokan,
    };

    var body = jsonEncode(bodi);
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/contributor/pickup_orders/post/"),
        body: body);
    final data = jsonDecode(response.body);

    setState(() {
      _loading = false;
      status = data["status"].toString();
    });
    print("statusSend: " + status);
    // print("nama_penerima: " + nama_penerima[0]);
    // print("no_telepon_penerima: " + no_telepon_penerima[0]);
    // print("kode_pos: " + kode_pos[0]);

    // final response = await http.post(
    //     Uri.parse("http://192.168.1.14:8099/flutter/register.php"),
    //     headers: {"Access-Control-Allow-Origin": "*"},
    //     body: {"nama": nama, "email": email, "password": password});
    // final data = jsonDecode(response.body);
    // int value = data['value'];
    // String pesan = data['message'];
    // if (status == "success") {
    //   setState(() {
    //     Navigator.pop(context);
    //   });
    // } else {
    //   print(pesan);
    // }
  }

  getAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //_token = (preferences.getString('token') ?? '');
    _token = preferences.getString("token");
    Map bodi = {
      "token": _token,
    };

    var body = jsonEncode(bodi);
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/contributor/user/addresses/get/"),
        body: body);
    ResponseAddress data = responseAddressFromJson(response.body);

    setState(() {
      _loading = false;
      status.add(data.status.toString());
      pesan.add(data.message.toString());
      id_alamat.add(data.addresses[0].id.toString());
      alamat.add(data.addresses[0].address.toString());
      kota.add(data.addresses[0].cityId.toString());
      nama_penerima.add(data.addresses[0].recipientName.toString());
      no_telepon_penerima.add(data.addresses[0].phoneNumber.toString());
      kode_pos.add(data.addresses[0].postalCode.toString());
    });
    // print("address: " + alamat[0]);
    // print("kota: " + kota[0]);
    // print("nama_penerima: " + nama_penerima[0]);
    // print("no_telepon_penerima: " + no_telepon_penerima[0]);
    // print("kode_pos: " + kode_pos[0]);

    // final response = await http.post(
    //     Uri.parse("http://192.168.1.14:8099/flutter/register.php"),
    //     headers: {"Access-Control-Allow-Origin": "*"},
    //     body: {"nama": nama, "email": email, "password": password});
    // final data = jsonDecode(response.body);
    // int value = data['value'];
    // String pesan = data['message'];
    // if (status == "success") {
    //   setState(() {
    //     Navigator.pop(context);
    //   });
    // } else {
    //   print(pesan);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
    _loading = true;
    id_alamat = [];
    status = [];
    pesan = [];
    alamat = [];
    kota = [];
    nama_penerima = [];
    no_telepon_penerima = [];
    kode_pos = [];
    //
    // no_telepon_penerima2 = no_telepon_penerima[0];
    // status2 = status[0];
    // pesan2 = pesan[0];
    // alamat2 = alamat[0];
    // kota2 = kota[0];
    // nama_penerima2 = nama_penerima[0];
    // no_telepon_penerima2 = no_telepon_penerima[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(0, 43, 80, 1), //change your color here
        ),
        title: Text(
          "Jadwalkan Penjemputan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 43, 80, 1),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: kIsWeb ? 500.0 : double.infinity,
                child: Form(
                  key: _key,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          getBody(),
                        ],
                      ),
                    ),
                    // child: ListView(
                    //   padding: EdgeInsets.all(16.0),
                    //   children: <Widget>[
                    //     TextFormField(
                    //       validator: (e) {
                    //         if (e!.isEmpty) {
                    //           return "Please insert fullname";
                    //         }
                    //       },
                    //       onSaved: (e) => nama = e!,
                    //       decoration: InputDecoration(labelText: "Nama Lengkap"),
                    //     ),
                    //     TextFormField(
                    //       validator: (e) {
                    //         if (e!.isEmpty) {
                    //           return "Please insert email";
                    //         }
                    //       },
                    //       onSaved: (e) => email = e!,
                    //       decoration: InputDecoration(labelText: "email"),
                    //     ),
                    //     TextFormField(
                    //       obscureText: _secureText,
                    //       onSaved: (e) => password = e!,
                    //       decoration: InputDecoration(
                    //         labelText: "Password",
                    //         suffixIcon: IconButton(
                    //           onPressed: showHide,
                    //           icon: Icon(_secureText
                    //               ? Icons.visibility_off
                    //               : Icons.visibility),
                    //         ),
                    //       ),
                    //       validator: (e) {
                    //         if (e!.isEmpty) {
                    //           return "Please insert Password";
                    //         }
                    //       },
                    //     ),
                    //     MaterialButton(
                    //       onPressed: () {
                    //         check();
                    //       },
                    //       child: Text("Register"),
                    //     )
                    //   ],
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    if (alamat.isEmpty) {
      if (_loading) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        );
      }
    } else {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Alamat',
              style: TextStyle(color: Color(0xff283c71)),
            ),
            TextFormField(
              initialValue: alamat[0],
              enabled: false,
              style: TextStyle(color: Color(0xff283c71)),
              validator: (e) {
                if (e!.isEmpty) {
                  return "Masukan Alamat";
                }
              },
              onSaved: (e) => alamat[0] = e!,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                //hintText: "Masukan Alamat",
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Kode Pos',
              style: TextStyle(color: Color(0xff283c71)),
            ),
            TextFormField(
              initialValue: kode_pos[0],
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              style: TextStyle(color: Color(0xff283c71)),
              validator: (e) {
                if (e!.isEmpty) {
                  return "Masukan Kode Pos";
                }
              },
              onSaved: (e) => kode_pos[0] = e!,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                //hintText: "Masukan Kode Pos",
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nama Penerima',
              style: TextStyle(color: Color(0xff283c71)),
            ),
            TextFormField(
              initialValue: nama_penerima[0],
              enabled: false,
              style: TextStyle(color: Color(0xff283c71)),
              validator: (e) {
                if (e!.isEmpty) {
                  return "Masukan Nama Penerima";
                }
              },
              onSaved: (e) => nama_penerima[0] = e!,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                //hintText: "Masukan Nama Penerima",
              ),
            ),
            SizedBox(height: 10),
            Text(
              'No Telepon Penerima',
              style: TextStyle(color: Color(0xff283c71)),
            ),
            TextFormField(
              initialValue: no_telepon_penerima[0],
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              style: TextStyle(color: Color(0xff283c71)),
              validator: (e) {
                if (e!.isEmpty) {
                  return "Masukan No Telepon Penerima";
                }
              },
              onSaved: (e) => no_telepon_penerima[0] = e!,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                //hintText: "(cth: 08123456789)",
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Volume Pasokan (Liter)',
              style: TextStyle(color: Color(0xff283c71)),
            ),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: TextStyle(color: Color(0xff283c71)),
              validator: (e) {
                if (e!.isEmpty) {
                  return "Masukan Volume Pasokan (dalam Liter)";
                }
              },
              onSaved: (e) => volume_pasokan = e!,
              decoration: InputDecoration(
                hintText: "Masukan Volume",
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 25),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff2f9efc),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                  onPressed: () {
                    showAlertDialogPenjadwalanPenjemputan(context);
                    ;
                  },
                  child: Text('Jadwalkan Penjemputan',
                      style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  void showAlertDialogPenjadwalanPenjemputan(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Ya"),
      onPressed: () {
        setPenjadwalanPenjemputan();
        Navigator.of(context).pop();
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => Historis(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 300),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Jadwalkan Penjemputan"),
      content: Text("Apakah anda yakin data-data sudah benar?"),
      actions: [
        cancelButton,
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
