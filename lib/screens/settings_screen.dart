import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: [
          Container(
            width: 135,
            height: 135,
            child: CircleAvatar(
              // child: Image.asset(
              //   'images/Bg.png',
              //   width: 235,
              //   height: 235,
              // ),

              backgroundImage: AssetImage('images/Bg.png'),
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Text('John Deo',style: TextStyle(
            fontSize: 20,
            color: Color(0xff444657),
          ),),
          SizedBox(
            height: 5,
          ),
          Text('mm@gmail.com',style: TextStyle(
            fontSize: 16,
            color: Color(0xff444657),
          ),),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.red,
            ),
            title: Text('info'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.red,
            ),
            title: Text('Language'),
            onTap: () {
              showLanguageBottomSheet();
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text('Log OuT'),
            onTap: () {
              showAleertDialog();
            },
          ),
        ],
      ),
    );
  }

  void showAleertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
            title: Text("Are you sure?"),
            elevation: 5,
            titleTextStyle: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.white70,
                  elevation: 5,
                  backgroundColor: Colors.green,
                  side: BorderSide(width: 2, color: Colors.green),
                ),
                child: Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: Colors.white70,
                  elevation: 5,
                  backgroundColor: Colors.red,
                  side: BorderSide(width: 2, color: Colors.red),
                ),
                child: Text("No"),
              ),
              // InkWell(
              //   child:Text("Yes",style: TextStyle(
              //     color: Colors.green,
              //     fontSize: 18,
              //   ),) ,
              //   onTap: (){
              //
              //   },
              // ),
            ],
          );
        });
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        elevation: 0,
        isDismissible: true,
        builder: (context) {
          return Container(
            margin: EdgeInsets.all(10),
            child: BottomSheet(
                elevation: 3,
                backgroundColor: Colors.white70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )),
                onClosing: () {},
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    height: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            side: BorderSide(width: 2, color: Colors.grey),
                          ),
                          child: Text("Arabic"),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            side: BorderSide(width: 2, color: Colors.grey),
                          ),
                          child: Text("English"),
                        ),
                        /*
                          ListTile(
                          leading: Icon(
                          Icons.language,
                          color: Colors.red,
                          ),
                          title: Text('Arabic'),
                          onTap: (){
                            showLanguageBottomSheet();
                          },
                          trailing: Icon(
                            Icons.check_circle_outline_sharp,
                            size: 14,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          title: Text('English'),
                          trailing: Icon(
                            Icons.check,
                            size: 14,
                          ),
                        ),
                        */
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
