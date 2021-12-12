import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_jelantah_utama/models/responseUserCity.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String email, password, confirm_password, nama;
  late String nama_depan,
      nama_belakang,
      kode_pos,
      alamat,
      nomor_telepon,
      nama_penerima,
      nomor_telepon_penerima;
  int price = 4000;
  late int id_city;

  final _key = new GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _Controller = TextEditingController();
  var confirmPass;

  var listcity;

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  checkAndSave() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    id_city = id_city.toInt();
    Map bodi = {
      "first_name": nama_depan,
      "last_name": nama_belakang,
      "email": email,
      "password": password,
      "confirm_password": confirm_password,
      "phone_number": nomor_telepon,
      "level": "contributor",
      "price": 4000,
      "addresses": [
        {
          "address": alamat,
          "city": id_city,
          "postal_code": kode_pos,
          "recipient_name": nama_penerima,
          "phone_number": nomor_telepon_penerima,
          "latitude": null,
          "longitude": null
        }
      ]
    };
    var body = jsonEncode(bodi);
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/contributor/user/post/"),
        body: body);
    final data = jsonDecode(response.body);

    String token = data['token'];
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
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  'Nama Depan',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Nama Depan";
                                    }
                                  },
                                  onSaved: (e) => nama_depan = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Nama Depan",
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Nama Belakang',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Nama Belakang";
                                    }
                                  },
                                  onSaved: (e) => nama_belakang = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Nama Belakang",
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Email',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(e!);
                                    if (e!.isEmpty) {
                                      return "Masukan Email";
                                    }
                                    if (emailValid == false) {
                                      return "Format Email salah";
                                    }
                                  },
                                  onSaved: (e) => email = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Email",
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Password',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  controller: _pass,
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
                                    confirmPass = e;
                                    if (e!.isEmpty) {
                                      return "Masukan Password";
                                    }
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Konfirmasi Password',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  controller: _confirmPass,
                                  style: TextStyle(color: Color(0xff283c71)),
                                  obscureText: _secureText,
                                  onSaved: (e) => confirm_password = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Konfirmasi Password",
                                    suffixIcon: IconButton(
                                      onPressed: showHide,
                                      icon: Icon(_secureText
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                    ),
                                  ),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Konfirmasi Password";
                                    }
                                    if (e! != confirmPass) {
                                      return 'Password Berbeda';
                                    }
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Nomor Telepon',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  //controller: _controller,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Nomor Telepon";
                                    }
                                  },
                                  onSaved: (e) => nomor_telepon = e!,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Masukan Nomor Telepon (cth: 08123456789)",
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Alamat',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Alamat";
                                    }
                                  },
                                  onSaved: (e) => alamat = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Alamat",
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Kota',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TypeAheadFormField<City?>(
                                  //controller: _controller,
                                  hideSuggestionsOnKeyboardHide: false,
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    controller: _Controller,
                                    decoration: InputDecoration(
                                      // prefixIcon: Icon(Icons.search),
                                      // border: OutlineInputBorder(),
                                      hintText: 'Masukan Kota',
                                    ),
                                  ),
                                  suggestionsCallback:
                                      UserApi.getUserSuggestions,
                                  itemBuilder: (context, City? suggestion) {
                                    final city = suggestion!;

                                    return ListTile(
                                      title: Text(city.name),
                                    );
                                  },
                                  noItemsFoundBuilder: (context) => Container(
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        'Kota tidak ditemukan.',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                  onSuggestionSelected: (City? suggestion) {
                                    final city = suggestion!;
                                    id_city = city.id;
                                    //print("user:" + user.name.toString());
                                    _Controller.text = city.name;
                                    // ScaffoldMessenger.of(context)
                                    //   ..removeCurrentSnackBar()
                                    //   ..showSnackBar(SnackBar(
                                    //     content: Text('Selected user: ${user.name}'),
                                    //   ));
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please select a city';
                                    }
                                  },
                                  onSaved: (value) =>
                                      value = id_city.toString(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Kode Pos',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Kode Pos";
                                    }
                                  },
                                  onSaved: (e) => kode_pos = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Kode Pos",
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Nama Penerima',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Nama Penerima";
                                    }
                                  },
                                  onSaved: (e) => nama_penerima = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Nama Penerima",
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'No Telepon Penerima',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan No Telepon Penerima";
                                    }
                                  },
                                  onSaved: (e) => nomor_telepon_penerima = e!,
                                  decoration: InputDecoration(
                                    hintText: "(cth: 08123456789)",
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
                                        checkAndSave();
                                      },
                                      child: Text('Daftar',
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

class UserApi {
  static Future<List<City>> getUserSuggestions(String query) async {
    Map bodi = {
      "token": "",
    };
    var body = jsonEncode(bodi);
    final response = await http.post(
        Uri.parse("http://10.0.2.2:8000/api/contributor/cities/get/"),
        body: body);
    ResponseUserCity _data = responseUserCityFromJson(response.body);
    //developer.log(response.body);
    String statusrespon = _data.status;
    print("statusnnyaa: " + statusrespon);
    String cityrespon = _data.cities[0].name;
    print("cityrespon: " + cityrespon);
    List xx = _data.cities;

    if (response.statusCode == 200) {
      //final List users = json.decode(response.body);
      ResponseUserCity _data = responseUserCityFromJson(response.body);
      // print("cityy: " +
      //     users
      //         .map((json) => ResponseUserCity.fromJson(json))
      //         .toList()
      //         .toString());
      return _data.cities.where((city) {
        final nameLower = city.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
      return _data.cities;
      //return _data.map((json) => City.fromJson(json)).toList();
      //return xx;
    } else {
      throw Exception();
    }
  }
}
