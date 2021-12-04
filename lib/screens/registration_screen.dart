import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email, password, nama;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    final response = await http.post(
        Uri.parse("http://192.168.1.14:8099/flutter/register.php"),
        headers: {"Access-Control-Allow-Origin": "*"},
        body: {"nama": nama, "email": email, "password": password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(0, 43, 80, 1), //change your color here
        ),
        title: Text(
          "Daftar",
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
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  'Email / No Telp',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Email / No Telp";
                                    }
                                  },
                                  onSaved: (e) => email = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Email / No Telp",
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Password',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Color(0xff283c71)),
                                  obscureText: _secureText,
                                  onSaved: (e) => password = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Password",
                                    suffixIcon: IconButton(
                                      onPressed: showHide,
                                      icon: Icon(_secureText
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                  ),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Please insert password";
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
                                        check();
                                      },
                                      child: Text('Masuk',
                                          style:
                                              TextStyle(color: Colors.white))),
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
  }
}
