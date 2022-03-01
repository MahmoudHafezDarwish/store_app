import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/data/RouterHelper.dart';
import 'package:store_app/provider/AppProvider.dart';
import 'package:store_app/screens/bottom_home_navigation.dart';
import 'package:store_app/screens/home_cart_screen.dart';
import 'package:store_app/screens/home_screen.dart';
import 'package:store_app/screens/login_screen.dart';
import 'package:store_app/screens/main_screen.dart';
import 'package:store_app/screens/outboarding/outboarding_screen.dart';
import 'package:store_app/screens/payment_mode.dart';
import 'package:store_app/screens/payment_successful.dart';
import 'package:store_app/screens/products_details_screen.dart';
import 'package:store_app/screens/rating_screen.dart';
import 'package:store_app/screens/settings_screen.dart';
import 'package:store_app/screens/signup_screen.dart';
import 'package:store_app/screens/splash_screen.dart';
import 'package:store_app/screens/tabBar/cart_screen.dart';
import 'package:store_app/screens/tabBar/history_order_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MainAp(),
  );
}

class MainAp extends StatefulWidget {
  const MainAp({Key key}) : super(key: key);

  @override
  _MainApState createState() => _MainApState();
}

class _MainApState extends State<MainAp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: RouterHelper.routerHelper.routerKey,
        initialRoute: '/splash',
        routes: RouterHelper.routerHelper.map,
      ),
    );
  }
}
