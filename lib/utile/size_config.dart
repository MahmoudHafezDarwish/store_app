import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth=0;
  static double screenHeight=0;
  static double blockWidth = 0;
  static double blockHeight = 0;
  static double textMutilplier=0;
  static double imageSizeMutilplier=0;
  static double hightMutilplier=0;
  static double widthMutilplier=0;
  static double deviceRatio=0;
  static bool isPortrate = true;
  static bool isMobilePortrate = false;

  static double _safeAreaHorizontal=0;
  static double _safeAreaVertical=0;
  static double safeBlockHorizontal=0;
  static double safeBlockVertical=0;

  void init(BuildContext context) {
      _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    print("screenWidth = _mediaQueryData.size.width==$screenWidth");
    print("screenHeight = _mediaQueryData.size.height==$screenHeight");
    blockWidth = screenWidth / 100;
    print("blockWidth = screenWidth / 100;==$blockWidth");
    blockHeight = screenHeight / 100;
    print("blockHeight = screenHeight / 100==$blockHeight");
    textMutilplier = blockHeight;
    hightMutilplier = blockHeight;
    widthMutilplier = blockWidth;
    imageSizeMutilplier = blockWidth;
    deviceRatio = screenWidth / screenHeight;
    isMobilePortrate =_mediaQueryData.orientation==Orientation.portrait;


    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

  }

  static double scaleTextFont(double fontSize) {
    //8.96 is block Height of screen 896/100 ====blockHeight
    //double scale = fontSize / 8.96;
    double scale = fontSize / 7.31;
    return (textMutilplier * scale);
  }




  static double scaleWidth(double width) {
    // 3.75 width of device /100 (375/100) ====blockWidth
    //double scaleWidth = width / 3.75;
    double scaleWidth = width / 4.11;
    return (widthMutilplier * scaleWidth);
  }

  static double scaleHeight(double height) {
    //8.12 is block Height of screen 812/100 ====blockHeight
    //double scale = height/8.12;
    double scale = height / 7.31;
    return (hightMutilplier * scale);
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
