import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/menu_page.dart';
import 'pages/cart.dart';
import 'pages/constants.dart';
import 'pages/item_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme:ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor:Colors.white,
//textTheme: TextTheme(
// bodyText1: TextStyle(
//   fontSize: 1.0
// )
//),

//pageTransitionsTheme:  PageTransitionsTheme(
//  builders: ZoomPageTransitionsBuilder
//)
//        typography: Typography(
//          black:
//        )
      ),
      initialRoute: WelcomePage.id,
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        MenuPage.id: (context) => MenuPage(),
        Cart.id: (context) => Cart(),
        ItemPage.id: (context) => ItemPage(),

      },
    );
  }
}
