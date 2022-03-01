import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/models/screen.dart';
import 'package:store_app/screens/home_screen.dart';
import 'package:store_app/screens/profile_screen.dart';
import 'package:store_app/screens/tabBar/cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _widget = HomeScreen();
  int selectedIndex = 0;

  // List<Widget> _screens = [HomeScreen(), ProfileScreen()];
  List<Screen> _screens = [
    Screen(HomeScreen(), 'Home'),
    Screen(CartScreen(), 'Cart')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens.elementAt(selectedIndex).title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            )),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Flutter course"),
              accountEmail: Text("Flutter course app"),
              currentAccountPicture: Icon(Icons.person),
              otherAccountsPictures: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
              ],
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        color: Colors.red.withOpacity(0.56),
                        blurRadius: 3,
                        spreadRadius: 2)
                  ]),

              //margin: EdgeInsets.all(10),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              onTap: () {
                if (selectedIndex != 1) {
                  setState(() {
                    selectedIndex = 1;
                  });
                }

                // if (_widget != ProfileScreen()) _widget = ProfileScreen();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              onTap: () {
                if (selectedIndex != 0) {
                  setState(() {
                    selectedIndex = 0;
                  });
                }

                // if (_widget != ProfileScreen()) _widget = ProfileScreen();
                Navigator.pop(context);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  Navigator.pushNamed(context, '/cart');
                });
              },
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            ),
            Divider(
              thickness: 3,
              color: Colors.black26,
              indent: 10,
              endIndent: 10,
              height: 30,
            ),
            ListTile(
              leading: Icon(Icons.settings_applications),
              title: Text('Setting'),
              onTap: () {
                print(' Navigator.');
                setState(() {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, '/setting');
                });
              },
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _screens.elementAt(selectedIndex).widget,
    );
  }
}
