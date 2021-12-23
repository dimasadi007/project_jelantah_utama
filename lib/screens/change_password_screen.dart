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

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

enum LoginStatusAccountScreen { notSignIn, signIn }

class _ChangePasswordState extends State<ChangePassword> {
  LoginStatusAccountScreen _loginStatus = LoginStatusAccountScreen.notSignIn;
  late String email, password, confirm_password, nama;
  var _token, status;
  final _key = new GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _Controller = TextEditingController();
  final focusNode = FocusNode();
  var confirmPass;

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
      "password": password,
      "confirm_password": confirm_password,
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
      Uri.parse("http://10.0.2.2:8000/api/contributor/session/delete"),
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
                                      'Password Baru',
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                    ),
                                    TextFormField(
                                      controller: _pass,
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                      obscureText: _secureText,
                                      onSaved: (e) => password = e!,
                                      decoration: InputDecoration(
                                        hintText: "Masukan Password Baru",
                                        suffixIcon: IconButton(
                                          onPressed: showHide,
                                          icon: Icon(_secureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                      ),
                                      validator: (e) {
                                        confirmPass = e;
                                        if (e!.isEmpty) {
                                          return "Masukan Password Baru";
                                        }
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Konfirmasi Password Baru',
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                    ),
                                    TextFormField(
                                      controller: _confirmPass,
                                      style:
                                          TextStyle(color: Color(0xff283c71)),
                                      obscureText: _secureText,
                                      onSaved: (e) => confirm_password = e!,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Masukan Konfirmasi Password Baru",
                                        suffixIcon: IconButton(
                                          onPressed: showHide,
                                          icon: Icon(_secureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                      ),
                                      validator: (e) {
                                        if (e!.isEmpty) {
                                          return "Masukan Konfirmasi Password Baru";
                                        }
                                        if (e! != confirmPass) {
                                          return 'Password Berbeda';
                                        }
                                      },
                                    ),
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
                                            showAlertDialogChangePassword(
                                                context);
                                          },
                                          child: Text('Ubah Password',
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ),
                                  ],
                                ),
                              ),
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
      case LoginStatusAccountScreen.notSignIn:
        return DashboardGuest();
    }
  }

  void showAlertDialogChangePassword(BuildContext context) {
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
      title: Text("Ubah Sandi"),
      content: Text("     Apakah anda ingin mengubah kata sandi?"
          "\n\n     Akun anda akan otomatis logout setelah penggantian sandi berhasil dilakukan!"),
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
