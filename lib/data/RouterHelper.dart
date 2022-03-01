import 'package:flutter/material.dart';
import 'package:store_app/screens/bottom_home_navigation.dart';
import 'package:store_app/screens/home_cart_screen.dart';
import 'package:store_app/screens/login_screen.dart';
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

class RouterHelper {
  RouterHelper._();

  static RouterHelper routerHelper = RouterHelper._();
  GlobalKey<NavigatorState> routerKey = GlobalKey<NavigatorState>();

  routingToSpecificWidget(Widget widget) {
    BuildContext context = routerKey.currentState.context;
    routerKey.currentState
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  routingToSpecificWidgetWithoutPop(Widget widget) {
    BuildContext context = routerKey.currentState.context;
    routerKey.currentState.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }


  popFunction() {
    routerKey.currentState.pop();
  }

  pushToSpecificScreenByNameWithoutPop(String screenName) {
    routerKey.currentState.pushNamed(screenName);
  }

  pushToSpecificScreenByNameWithPop(String screenName) {
    routerKey.currentState.pushNamed(screenName);
  }

  Map<String, Widget Function(BuildContext)> map = {
    '/splash': (context) => SplashScreen(),
    '/OutBoardingScreen': (context) => OutboardingScreen(),
    '/login': (context) => LoginScreen(),
    '/signup': (context) => SignupScreen(),
    // '/main':(context)=>MainScreen(),
    '/main': (context) => HomeScreenBottom(),
    '/setting': (context) => SettingScreen(),
    '/cart': (context) => CartScreen(),
    '/detailsScreen': (context) => HomeCartScreen(),
    '/homeCartScreen': (context) => ProductDtails(),
    '/PaymentSuccessful': (context) => PaymentSuccessfulScreen(),
    '/PaymentMode': (context) => PaymentMode(),
    '/RatingScreen': (context) => RatingScreen(),
    '/HistoryOrderScreen': (context) => HistoryOrderScreen(),
  };
}
