import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_jelantah_utama/screens/account_screen.dart';
import 'package:project_jelantah_utama/screens/login_screen.dart';
import 'package:project_jelantah_utama/screens/registration_screen.dart';
import 'package:project_jelantah_utama/screens/tentang_kami_screen.dart';
import 'package:project_jelantah_utama/screens/chat_admin.dart';
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
        'login_screen': (context) => LoginPage(),
        'registration_screen': (context) => Register(),
        'tentang_kami_screen': (context) => TentangKamiScreen(),
        //...
        //...
        //'main_history': (context) => MainHistory(),

        'chat_admin': (context) => ChatAdminPage(
              title: 'Admin',
            ),
        'account': (context) => Account(),
      },
      //home: SplashScreen(),
    );
  }
}
