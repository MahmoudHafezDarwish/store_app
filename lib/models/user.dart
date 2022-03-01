class Useer {
  String _first_name;
  String _last_name;
  String _email;
  String _phone;
  String _password;

  String get first_name => _first_name;

  set first_name(String value) {
    _first_name = value;
  }


  Useer([this._first_name, this._last_name, this._email, this._phone,
      this._password]);

  String get last_name => _last_name;

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  set last_name(String value) {
    _last_name = value;
  }
}
