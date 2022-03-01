import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:store_app/provider/AppProvider.dart';
import 'package:store_app/utile/size_config.dart';
import 'package:store_app/utile/tost.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _email;
  TextEditingController _password;
  var formKey;
  bool isPassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    formKey = GlobalKey<FormState>();
    isPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 30, right: 10),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //   margin: EdgeInsetsDirectional.only(top: 20,bottom: 20),
                  //   width: 80,
                  //   height: 80,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     color: Colors.red,
                  //     shape: BoxShape.circle,
                  //     image: DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: NetworkImage(
                  //             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDvHHeO_OvqgXATx3pqefutpdJ8pntH1wphGBTScJ4Ir29RJwmA5-1O2KP2rQQEX-AW8s&usqp=CAU")),
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsetsDirectional.only(
                      top: 80,
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Besley-Bold",
                        letterSpacing: 2,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    "Login to start using app,",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Besley-Regular",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Container(
                    width: 319,
                    height: 270,
                    color: Colors.white,
                    margin: EdgeInsetsDirectional.only(start: 28, end: 28),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _email,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                fontFamily: "Besley-Medium",
                                color: Colors.blue,
                              ),
                              onChanged: (value) {
                                print("_passord${_email.text}");
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email must not be null';
                                } else {
                                  return null;
                                }
                              },
                              onFieldSubmitted: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                hintText: "Email",
                                // enabledBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //       color: Colors.black,
                                //       width: 5,
                                //     ),
                                //     borderRadius: BorderRadius.circular(10)),
                                // focusedBorder: OutlineInputBorder(
                                //     borderSide: BorderSide(
                                //       color: Colors.black,
                                //       width: 5,
                                //     ),
                                //     borderRadius: BorderRadius.circular(10)),
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
                              height: 28,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                textAlignVertical: TextAlignVertical.center,
                                controller: _password,
                                obscureText: isPassword,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  fontFamily: "Besley-Regular",
                                  color: Colors.blue,
                                ),
                                onChanged: (value) {
                                  print("_passord${_password.text}");
                                },
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
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPassword ?Icons.remove_red_eye:Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPassword = !isPassword;
                                      });
                                    },
                                  ),

                                  // enabledBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: Colors.white,
                                  //     style: BorderStyle.solid,
                                  //     width: 5,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  // focusedBorder: OutlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: Colors.white,
                                  //     width: 5,
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: Colors.blue,
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
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                padding: EdgeInsetsDirectional.all(20),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    print(
                                        "Email: ${_email.text}  Password : ${_password.text}");
                                  }
                                  logIn();
                                },
                                color: Colors.lightBlue,
                                textColor: Colors.white70,
                                child: Text(
                                  "Login",
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
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don’t have an account?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      fontFamily: "Besley-Regular",
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        fontFamily: "Besley-Bold",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
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

  void logIn() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      //Navigator.pushReplacementNamed(context, '/main');
      // Navigator.pushReplacementNamed(context, '/main');
      Provider.of<AppProvider>(context, listen: false)
          .login(_email.text, _password.text);
      // ToastMessage.showToast("Is Done", true);
    } else {
      ToastMessage.showToast("User name or password is empty", false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }
}
