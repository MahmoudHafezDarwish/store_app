import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/data/RouterHelper.dart';
import 'package:store_app/models/screen.dart';
import 'package:store_app/provider/AppProvider.dart';
import 'package:store_app/screens/home_cart_screen.dart';
import 'package:store_app/screens/home_screen.dart';
import 'package:store_app/screens/settings_screen.dart';
import 'package:store_app/screens/tabBar/orders_screen.dart';
import 'package:store_app/utile/size_config.dart';

import 'add_new_product.dart';
import 'edit_product/edit_product_screen.dart';
import 'tabBar/cart_screen.dart';

class HomeScreenBottom extends StatefulWidget {
  int cameIndex;

  HomeScreenBottom({this.cameIndex});

  @override
  _HomeScreenBottomState createState() => _HomeScreenBottomState(cameIndex);
}

class _HomeScreenBottomState extends State<HomeScreenBottom> {
  int selectedIndex = 0;
  int indexN;

  _HomeScreenBottomState(this.indexN);


  // List<Widget> _screens = [HomeScreen(), ProfileScreen()];
  List<Screen> _screens = [
    Screen(OrdersSreen(), 'Home'),
    Screen(HomeCartScreen(), 'Cart'),
    Screen(SettingScreen(), 'Setting')
  ];

  @override
  void initState() {
    // TODO: implement initState
    if(this.indexN!=null){
      selectedIndex = indexN;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context,provider,x){
      return Scaffold(
        floatingActionButton: Visibility(
          visible: provider.loggedUser?.isAdmin ?? false,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              // RouterHelper.routerHelper
              //     .routingToSpecificWidgetWithoutPop(AddNewProduct());
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProductScreen()));
            },
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData.fallback(),
          title: Center(
            child: Text(_screens.elementAt(selectedIndex).title,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xff474559),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                )),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Navigator.pushNamed(context, '/add_task_screen');
              },
            ),
          ],
        ),
        body: _screens.elementAt(selectedIndex).widget,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.white,

          elevation: 10,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 18,
          selectedItemColor: Colors.blue,
          //fixedColor: Colors.grey.shade900,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              //title: Text("Home"),
              label: 'Home',
              backgroundColor: Colors.blue,
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              //title: Text("Home"),
              label: 'Cart',
              backgroundColor: Colors.blue,
              activeIcon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more_vert,
              ),
              //title: Text("Home"),
              label: 'More',
              backgroundColor: Colors.blue,
              activeIcon: Icon(Icons.more_vert),
            ),
          ],
        ),
      );
    });
  }
}
