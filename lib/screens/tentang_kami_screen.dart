import 'package:flutter/material.dart';

class TentangKamiScreen extends StatefulWidget {
  @override
  _TentangKamiScreenState createState() => _TentangKamiScreenState();
}

class _TentangKamiScreenState extends State<TentangKamiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
        backgroundColor: Colors.teal[300],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                //height: 260.0,
                //width: double.infinity,
                child: Image(
                  image: AssetImage('assets/jemput_jelantah_1.jpg'),
                  height: 260.0,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 9999,
                transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                //margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque elementum pulvinar risus, sit amet lacinia libero semper efficitur. Mauris ultricies, elit vitae volutpat vestibulum, enim ex maximus velit, ac dapibus metus ligula sit amet ex. Cras id commodo felis. "
                    "\n\n    Quisque viverra nisi eu tempor suscipit. Sed posuere egestas arcu, quis pellentesque eros vestibulum et. Aliquam interdum ut turpis ac faucibus. Phasellus elit lorem, vulputate sed ligula ut, aliquet sagittis lorem. Nullam varius ultrices dignissim.",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
