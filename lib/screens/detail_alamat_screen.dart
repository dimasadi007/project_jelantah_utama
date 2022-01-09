import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:project_jelantah_utama/models/responseUserCity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailAlamat extends StatefulWidget {
  final String alamat,
      kode_pos,
      nomor_telpon,
      recipient_name,
      city_id,
      lat,
      lng,
      id;

  DetailAlamat({
    required String this.alamat,
    required String this.kode_pos,
    required String this.nomor_telpon,
    required String this.recipient_name,
    required String this.city_id,
    required String this.lat,
    required String this.lng,
    required String this.id,
  });
  @override
  _DetailAlamatState createState() => _DetailAlamatState();
}

class _DetailAlamatState extends State<DetailAlamat> {
  late String email, password, confirm_password, nama, _token;
  var input_kode_pos,
      input_alamat,
      input_nomor_telepon,
      input_nama_penerima,
      input_nomor_telepon_penerima,
      input_id_city;
  //int price = 4000;
  var id_city;
  var _currentLocation;
  var lng;
  var lat;
  var lat_user, lng_user;
  final _key = new GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _Controller = TextEditingController();
  final focusNode = FocusNode();
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
      //getLat();
      //getLng();
      save();
    }
  }

  save() async {
    id_city = id_city.toInt();
    lat_user = double.parse(lat);
    lng_user = double.parse(lng);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString("token");
    String inputid = widget.id;
    Map bodi = {
      "token": _token,
      "address": input_alamat,
      "city_id": input_id_city,
      "postal_code": input_kode_pos,
      "recipient_name": input_nama_penerima,
      "phone_number": input_nomor_telepon_penerima
      // "latitude": lat_user,
      // "longitude": lng_user
    };
    var body = jsonEncode(bodi);
    final response = await http.post(
        Uri.parse(
            "http://10.0.2.2:8000/api/contributor/user/addresses/$inputid/put"),
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

  Future<Position> _determinePosition() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  getUserLocation() async {
    _currentLocation = await _determinePosition();
    setState(() {
      lat = _currentLocation.latitude.toString();
      lng = _currentLocation.longitude.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    int id_city;
    getUserLocation();
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
                                  'Alamat',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  initialValue: widget.alamat,
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Alamat";
                                    }
                                  },
                                  onSaved: (e) => input_alamat = e!,
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
                                  //initialValue: ,
                                  //controller: _controller,

                                  hideSuggestionsOnKeyboardHide: false,
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    //focusNode: focusNode,
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
                                      return 'Kota kosong! Mohon, dari pilihan yang ada, di klik kota domisili anda';
                                    } else if (id_city == null) {
                                      return 'Error! Dari pilihan yang ada, di klik domisili anda';
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
                                  initialValue: widget.kode_pos,
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
                                  onSaved: (e) => input_kode_pos = e!,
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
                                  initialValue: widget.recipient_name,
                                  style: TextStyle(color: Color(0xff283c71)),
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Masukan Nama Penerima";
                                    }
                                  },
                                  onSaved: (e) => input_nama_penerima = e!,
                                  decoration: InputDecoration(
                                    hintText: "Masukan Nama Penerima",
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'No Telepon (Penerima)',
                                  style: TextStyle(color: Color(0xff283c71)),
                                ),
                                TextFormField(
                                  initialValue: widget.nomor_telpon,
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
                                  onSaved: (e) =>
                                      input_nomor_telepon_penerima = e!,
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
                                      child: Text('Simpan',
                                          style:
                                              TextStyle(color: Colors.white))),
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
  }

  void showAlertDialogKota(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Oke"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ERROR!"),
      content:
          Text("Pilih KOTA dengan meng-klik dari pilihan-pilihan yang ada!"),
      actions: [
        cancelButton,
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
    //List xx = _data.cities;

    if (response.statusCode == 200) {
      //final List users = json.decode(response.body);
      ResponseUserCity _data = responseUserCityFromJson(response.body);

      return _data.cities.where((city) {
        final nameLower = city.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
      return _data.cities;
      //return _data.map((json) => City.fromJson(json)).toList();
      //return xx;
    } else {
      throw Exception("Error, silahkan coba masuk ulang halaman 'Daftar' ini.");
    }
  }
}
