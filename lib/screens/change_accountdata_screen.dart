import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_jelantah_utama/models/responseUserCity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_guest.dart';

class ChangeAccountdata extends StatefulWidget {
  final String firstname, lastname, phonenumber;

  ChangeAccountdata({
    required String this.firstname,
    required String this.lastname,
    required String this.phonenumber,
  });
  @override
  _ChangeAccountdataState createState() => _ChangeAccountdataState();
}

enum LoginStatusAccountScreen { notSignIn, signIn }

class _ChangeAccountdataState extends State<ChangeAccountdata> {
  LoginStatusAccountScreen _loginStatus = LoginStatusAccountScreen.notSignIn;
  //late String password, confirm_password, nama;
  var _token, status;
  final _key = new GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _Controller = TextEditingController();
  final focusNode = FocusNode();
  var confirmPass;
  var inputfirstname, inputlastname, inputphonenumber;

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        _token = preferences.getString('token');
        //print(_token);
        status = preferences.getString("status");
        _loginStatus = status == "success"
            ? LoginStatusAccountScreen.signIn
            : LoginStatusAccountScreen.notSignIn;
      },
    );
  }

  checkAndSave() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      //getLat();
      //getLng();
      save();
    }
  }

  save() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString("token");
    Map bodi = {
      "token": _token,
      "first_name": inputfirstname,
      "last_name": inputlastname,
      "phone_number": inputphonenumber,
    };
    var body = jsonEncode(bodi);
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/contributor/user/password/put"),
        body: body);
    final data = jsonDecode(response.body);

    //String token = data['token'];
    String status = data['status'];
    String pesan = data['message'];

    // final response = await http.post(
    //     Uri.parse("http://192.168.1.14:8099/flutter/register.php"),
    //     headers: {"Access-Control-Allow-Origin": "*"},
    //     body: {"nama": nama, "email": email, "password": password});
    // final data = jsonDecode(response.body);
    // int value = data['value'];
    // String pesan = data['message'];
    if (status == "success") {
      setState(() {
        //Navigator.pop(context);
        autologout();
      });
    } else {
      print(pesan);
    }
  }

  autologout() async {
    Map bodi = {"token": _token};
    var body = json.encode(bodi);
    final response = await http.post(
      Uri.parse("http://10.0.2.2:8000/api/contributor/user/put"),
      body: body,
    );
    final data = jsonDecode(response.body);
    var status = data['status'];
    if (status == "success") {
      signOut();
      // showAlertDialogChangePasswordBerhasil(context);
    } else {
      Navigator.of(context).pop();
    }
  }

  signOut() async {
    print("signout jalan");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("status", null);
      preferences.setString("token", null);
      preferences.commit();
      _loginStatus = LoginStatusAccountScreen.notSignIn;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DashboardGuest()));
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getPref();
    //int id_city;
    //getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatusAccountScreen.signIn:
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color.fromRGBO(0, 43, 80, 1), //change your color here
            ),
            title: Text(
              "Ubah Sandi",
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
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      'Nama Depan',
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                    ),
                                    TextFormField(
                                      initialValue: widget.firstname,
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                      validator: (e) {
                                        if (e!.isEmpty) {
                                          return "Masukan Nama Depan";
                                        }
                                      },
                                      onSaved: (e) => inputfirstname = e!,
                                      decoration: InputDecoration(
                                        hintText: "Masukan Nama Depan",
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Nama Belakang',
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                    ),
                                    TextFormField(
                                      initialValue: widget.lastname,
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                      validator: (e) {
                                        if (e!.isEmpty) {
                                          return "Masukan Nama Belakang";
                                        }
                                      },
                                      onSaved: (e) => inputlastname = e!,
                                      decoration: InputDecoration(
                                        hintText: "Masukan Nama Belakang",
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Nomor Telepon',
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                    ),
                                    TextFormField(
                                      initialValue: widget.phonenumber,
                                      //controller: _controller,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                      validator: (e) {
                                        if (e!.isEmpty) {
                                          return "Masukan Nomor Telepon";
                                        }
                                      },
                                      onSaved: (e) => inputphonenumber = e!,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Masukan Nomor Telepon (cth: 08123456789)",
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
                                            //checkAndSave();
                                            showAlertDialogChangeAccountdata(
                                                context);
                                          },
                                          child: Text('Ubah Data Akun',
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case LoginStatusAccountScreen.notSignIn:
        return DashboardGuest();
    }
  }

  void showAlertDialogChangeAccountdata(BuildContext context) {
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
        checkAndSave();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ubah Data Akun"),
      content: Text("Apakah anda ingin mengubah data akun anda?"),
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

  void showAlertDialogChangePasswordBerhasil(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Ya"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Berhasil Mengubah Sandi"),
      content: Text("Silahkan login kembali dengan sandi baru anda."),
      actions: [
        cancelButton,
        //continueButton,
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
