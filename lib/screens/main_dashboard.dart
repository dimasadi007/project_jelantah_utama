import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'history_item.dart';
import 'main_history2_old.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection_outlined),
            label: 'Video Tutorial',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int _selectedIndex) {
          setState(() {
            this._selectedIndex = _selectedIndex;
          });
        },
        //onTap: _onItemTapped,
      ),
      body: Stack(children: <Widget>[
        Offstage(
          offstage: _selectedIndex != 0,
          child: TickerMode(
            enabled: _selectedIndex == 0,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
                        child: Text(
                          'Selamat Datang,'
                          '\nAbc Def Ghi',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(25.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: DecoratedIcon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                          size: 40.0,
                          shadows: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black,
                            ),
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.lightBlueAccent,
                            ),
                          ],
                        ),
                        /*Icon(
                            Icons.account_circle_rounded,
                            size: 40,
                            color: Colors.white,
                          ),*/
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(45, 15, 45, 15),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Total Pasokan',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '100 L',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(45, 15, 45, 15),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Total Penghasilan',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Rp 4.000.000',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(45, 15, 45, 15),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Harga Minyak Jelantah / L',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Rp 4.000',
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Update: 27 September 2021',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(45, 15, 45, 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 6), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Jadwalkan Penjemputan',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                            Material(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(30.0),
                              elevation: 5.0,
                              child: MaterialButton(
                                  onPressed: () {
                                    //Go to login screen
                                  },
                                  minWidth: 20.0,
                                  height: 32.0,
                                  child: Icon(Icons.arrow_forward_rounded)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Offstage(
          offstage: _selectedIndex != 1,
          child: TickerMode(
            enabled: _selectedIndex == 1,
            child: MaterialApp(
              localizationsDelegates: [GlobalMaterialLocalizations.delegate],
              supportedLocales: [
                const Locale('en'),
                const Locale('id'),
                //const Locale('ID')
              ],
              initialRoute: 'main_history',
              routes: {
                // 'splash_screen': (context) => SplashScreen(),
                // 'welcome_screen': (context) => WelcomeScreen(),
                // 'login_screen': (context) => LoginScreen(),
                // 'registration_screen': (context) => RegistrationScreen(),
                // 'tentang_kami_screen': (context) => TentangKamiScreen(),
                //...
                'main_dashboard': (context) => MainDashboard(),
                //...
                'main_history': (context) => MainHistory(),
                'history_item': (context) => HistoryItem(),
              },
            ),
          ),
        ),
        Offstage(
          offstage: _selectedIndex != 2,
          child: TickerMode(
            enabled: _selectedIndex == 2,
            child: MaterialApp(
                //home: YourRightPage(),
                ),
          ),
        ),
        Offstage(
          offstage: _selectedIndex != 3,
          child: TickerMode(
            enabled: _selectedIndex == 3,
            child: MaterialApp(
                //home: YourRightPage(),
                ),
          ),
        ),
      ]),
    );
  }
}
