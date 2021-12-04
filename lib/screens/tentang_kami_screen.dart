import 'package:flutter/material.dart';

class TentangKamiScreen extends StatefulWidget {
  @override
  _TentangKamiScreenState createState() => _TentangKamiScreenState();
}

class _TentangKamiScreenState extends State<TentangKamiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Tentang Kami'),
      //   backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      // ),
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Expanded(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage("assets/images/mobil.PNG"),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              //height: 260.0,
              //width: double.infinity,
              child: Image(
                image: AssetImage('assets/jemput_jelantah_1.jpg'),
                height: 280.0,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 2064,
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              //margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "Tentang Kami",
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 43, 80, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque elementum pulvinar risus, sit amet lacinia libero semper efficitur. Mauris ultricies, elit vitae volutpat vestibulum, enim ex maximus velit, ac dapibus metus ligula sit amet ex. Cras id commodo felis. "
                          "\n\n    Quisque viverra nisi eu tems pelrdum ut turpis ac faucibus. Phasellus elit lorem, vulputate sed ligula ut, aliquet sagittis lorem. Nullam varius ultrices dignissim.",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color.fromRGBO(102, 128, 150, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
