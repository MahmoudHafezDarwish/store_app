import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/OutBoardingScreen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Image(
              image: AssetImage('images/splash.png'),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          PositionedDirectional(
              top: 150,
              start: 0,
              end: 0,
              child: Center(
                child:Column(
                  children: [
                    Text(
                      "MOMMA .",
                      style: TextStyle(
                          fontFamily: 'BesleyBlack',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 10,
                          fontSize: 24,
                          color: Colors.black,
                          backgroundColor: Colors.transparent),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "FASHIONS",
                      style: TextStyle(
                          fontFamily: 'Lobster-Regular',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black,
                          backgroundColor: Colors.transparent),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
