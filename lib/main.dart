import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_jelantah_utama/screens/login_screen.dart';
import 'package:project_jelantah_utama/screens/login_screen2.dart';
import 'package:project_jelantah_utama/screens/main_dashboard.dart';
import 'package:project_jelantah_utama/screens/main_history2_old.dart';
import 'package:project_jelantah_utama/screens/one_time_intro.dart';
import 'package:project_jelantah_utama/screens/one_time_intro_v2.dart';
import 'package:project_jelantah_utama/screens/registration_screen.dart';
import 'package:project_jelantah_utama/screens/registration_screen2.dart';
import 'package:project_jelantah_utama/screens/tentang_kami_screen.dart';
import 'package:project_jelantah_utama/screens/testcity.dart';
import 'package:project_jelantah_utama/screens/welcome_screen.dart';
import 'screens/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext contextP) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('en'),
        const Locale('id'),
        //const Locale('ID')
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        'splash_screen': (context) => SplashScreen(),
        'welcome_screen': (context) => WelcomeScreen(),
        'login_screen2': (context) => LoginScreen(),
        'login_screen': (context) => LoginPage(),
        'registration_screen2': (context) => RegistrationScreen(),
        'registration_screen': (context) => Register(),
        'tentang_kami_screen': (context) => TentangKamiScreen(),
        //...
        'main_dashboard': (context) => MainDashboard(),
        //...
        //'main_history': (context) => MainHistory(),
        'one_time_intro': (context) => CarouselWithIndicatorDemo(),
        'one_time_intro2': (context) => OnBoardingPage(),

        'testcity': (context) => MyHomePage(
              title: 'Admin',
            ),
      },
      //home: SplashScreen(),
    );
  }
}
