import 'package:flutter/cupertino.dart';

class Screen{
  Widget _widget;
  String _title;

  Screen(this._widget, this._title);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  Widget get widget => _widget;

  set widget(Widget value) {
    _widget = value;
  }
}