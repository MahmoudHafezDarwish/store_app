import 'package:flutter/material.dart';
import 'package:store_app/screens/outboarding/FirstScreen.dart';
import 'package:store_app/screens/outboarding/outboarding_dot.dart';

class OutboardingScreen extends StatefulWidget {
  const OutboardingScreen({Key key}) : super(key: key);

  @override
  _OutboardingScreenState createState() => _OutboardingScreenState();
}

class _OutboardingScreenState extends State<OutboardingScreen> {
  PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            onPageChanged: (int currentPageIndex) {
              setState(() {
                currentIndex = currentPageIndex;
              });
            },
            controller: pageController,
            children: [
              OutBoardingContentScreen(
                title: "Welcome!",
                subTitle:
                    "Now were up in the big leagues gettingour turn at bat. The Brady Bunch that's the way we  Brady Bunch..",
                image: 'images/outboard_image1.png',
              ),
              OutBoardingContentScreen(
                title: "Add to cart",
                subTitle:
                    "Now were up in the big leagues gettingour turn at bat. The Brady Bunch that's the way we  Brady Bunch..",
                image: 'images/outboard_image2.png',
              ),
              OutBoardingContentScreen(
                title: "Enjoy Purchase!",
                subTitle:
                    "Now were up in the big leagues gettingour turn at bat. The Brady Bunch that's the way we  Brady Bunch..",
                image: 'images/outboard_image3.png',
              ),
            ],
          ),
          if (currentIndex != 2)
            PositionedDirectional(
              end: 15,
              top: 30,
              child: ElevatedButton(
                onPressed: () {
                  pageController.jumpToPage(2);
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  //elevation: 3,
                ),
              ),
            ),
          PositionedDirectional(
              start: 0,
              end: 0,
              bottom: 10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutBoardingDot(
                        index: 0,
                        currentIndex: currentIndex,
                      ),
                      OutBoardingDot(
                        index: 1,
                        currentIndex: currentIndex,
                      ),
                      OutBoardingDot(
                        index: 2,
                        currentIndex: currentIndex,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (currentIndex == 2)
                    Container(
                      width: 315,
                      height: 53,
                      child: ElevatedButton(
                        onPressed: () {

                          Navigator.pushNamed(context, "/login");
                          // Navigator.pushNamed(context, "/detailsScreen");
                        },

                        child: Text('Start'),
                        style: ElevatedButton.styleFrom(

                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back_ios,
                            color: currentIndex == 0
                                ? Colors.black.withOpacity(0.2)
                                : Colors.black),
                        onTap: () {
                          pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInBack);
                        },
                      ),
                      InkWell(
                        child: Icon(Icons.arrow_forward_ios,
                            color: currentIndex == 2
                                ? Colors.black.withOpacity(0.2)
                                : Colors.black),
                        onTap: () {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
}
