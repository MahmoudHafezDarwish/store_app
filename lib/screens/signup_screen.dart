import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/MyUsres.dart';
import 'package:store_app/provider/AppProvider.dart';
import 'package:store_app/utile/tost.dart';
import 'package:string_validator/string_validator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _email;
  TextEditingController _phone;
  TextEditingController _firstName;
  TextEditingController _address;
  TextEditingController _password;
  bool isPassword = true;
  var formKey;
  bool isAccept = false;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    _phone = TextEditingController();
    _firstName = TextEditingController();
    _address = TextEditingController();
    isPassword = true;
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    _firstName.dispose();
    _address.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 30, right: 10),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      top: 10,
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Besley-Bold",
                        letterSpacing: 2,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Create an account",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.2),
                      fontFamily: "Besley-Regular",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 319,
                    height: 440,
                    color: Colors.white,
                    margin: EdgeInsetsDirectional.only(start: 25, end: 25),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        // autovalidateMode:AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _firstName,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: "Besley-Medium",
                                color: Colors.blue,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'First name must not be null';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                hintText: "Name",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontFamily: "Besley-Regular",
                                  color: Colors.black.withOpacity(.5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _address,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: "Besley-Medium",
                                color: Colors.blue,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Address must not be null';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Address",
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                ),
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontFamily: "Besley-Regular",
                                  color: Colors.black.withOpacity(.5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _email,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: "Besley-Medium",
                                color: Colors.blue,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email must not be null';
                                } else {
                                  bool valid = isEmail(value);
                                  valid
                                      ? ToastMessage.showToast("isEmail", valid)
                                      : ToastMessage.showToast(
                                          "is Not Email", valid);
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.blue,
                                ),
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontFamily: "Besley-Regular",
                                  color: Colors.black.withOpacity(.5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _phone,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: "Besley-Medium",
                                color: Colors.blue,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Phone number must not be null';
                                } else {
                                  bool valid = isNumeric(value);
                                  valid
                                      ? ToastMessage.showToast("isPhone", valid)
                                      : ToastMessage.showToast(
                                          "is Not Email", valid);

                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Phone",
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                ),
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontFamily: "Besley-Regular",
                                  color: Colors.black.withOpacity(.5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                textAlignVertical: TextAlignVertical.center,
                                controller: _password,
                                obscureText: isPassword,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  fontFamily: "Besley-Regular",
                                  color: Colors.blue,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Password must not be null';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsetsDirectional.only(start: 10),
                                  hintText: "password",
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: Colors.blue,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPassword
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPassword = !isPassword;
                                      });
                                    },
                                  ),
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    fontFamily: "Besley-Regular",
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            FormField(
                              validator: (isValid) {},
                              onSaved: (value) {},
                              builder: (context) {
                                return CheckboxListTile(
                                  value: this.isAccept,
                                  onChanged: (v) {},
                                  title: Text('Accept :'),
                                );
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                padding: EdgeInsetsDirectional.all(20),
                                onPressed: () {
                                  signUp();
                                  // if (formKey.currentState.validate()) {
                                  //   ToastMessage.showToast("Is Done", true);
                                  //
                                  //   print(
                                  //       "Email: ${_email.text}  Password : ${_password.text}");
                                  // } else {
                                  //   ToastMessage.showToast(
                                  //       "User name or password is empty",
                                  //       false);
                                  // }
                                  print(
                                      "Email: ${_email.text}  Password : ${_password.text}");
                                },
                                color: Colors.lightBlue,
                                textColor: Colors.white70,
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    fontFamily: "Tajawal",
                                    color: Colors.white,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() {
    if (formKey.currentState.validate()) {
      ToastMessage.showToast("Is Done", true);
      Navigator.pushNamed(context, "/main");
    } else {
      ToastMessage.showToast("Data is empty", false);
    }
    if (_email.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        _firstName.text.isNotEmpty &&
        _address.text.isNotEmpty &&
        _phone.text.isNotEmpty) {
      MyUser myUser = MyUser(
        email: _email.text,
        password: _password.text,
        address: _address.text,
        name: _firstName.text,
        phoneNumber: _phone.text,
        display_picture: null,
        favourite_products: null,
      );
      Provider.of<AppProvider>(context, listen: false).signUp(myUser);
      // ToastMessage.showToast("Is Done", true);
      // Navigator.pushNamed(context, "/main");
    }
    // else if ((_email.text.isNotEmpty && _email.text == 'admin@gmail.com') &&
    //     (_password.text.isNotEmpty && _password.text == 'admin') &&
    //     _firstName.text.isNotEmpty &&
    //     _address.text.isNotEmpty &&
    //     _phone.text.isNotEmpty) {
    //   MyUser myUser = MyUser(
    //       email: _email.text,
    //       password: _password.text,
    //       address: _address.text,
    //       name: _firstName.text,
    //       phoneNumber: _phone.text,
    //   isAdmin: true);
    //   Provider.of<AppProvider>(context,listen: false).signUp(myUser);
    //
    //   // ToastMessage.showToast("Data is empty", false);
    // }
  }
}
