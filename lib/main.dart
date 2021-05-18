import 'package:final_project2/Screens/control_view_screen.dart';
import 'package:final_project2/constants.dart';
import 'package:final_project2/route.dart';
import 'package:final_project2/view_models/auth_view_model.dart';
import 'package:final_project2/view_models/cart_view_model.dart';
import 'package:final_project2/view_models/category_view_model.dart';
import 'package:final_project2/view_models/control_view_model.dart';
import 'package:final_project2/view_models/order_view_model.dart';
import 'package:final_project2/view_models/product_view_model.dart';
import 'package:final_project2/view_models/profile_view_model.dart';
import 'package:final_project2/view_models/splash_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => ControlViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => OrderViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "Muli",
            textTheme: TextTheme(
              bodyText1: TextStyle(color: kTextColor),
              bodyText2: TextStyle(color: kTextColor),
            ),
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              brightness: Brightness.light,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: Color(0xFF888888),
                  fontSize: 18,
                ),
              ),
            )),
        initialRoute: ControlView.id,
        routes: routes,
      ),
    );
  }
}
