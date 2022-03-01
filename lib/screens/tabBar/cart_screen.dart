import 'package:flutter/material.dart';
import 'package:store_app/screens/tabBar/history_order_screen.dart';
import 'package:store_app/screens/tabBar/orders_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedTab = 0;
  List<Widget> _list_screens = [OrdersSreen(), HistoryOrderScreen()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _list_screens.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        bottom: TabBar(
          onTap: (int selectIndex) {

          },
          controller: _tabController,
          labelColor: Colors.amber,
          labelStyle: TextStyle(fontSize: 20),
          unselectedLabelStyle: TextStyle(fontSize: 16),
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.amber,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 4,
          tabs: [
            Tab(
              icon: Icon(
                Icons.shopping_cart,
              ),
              text: "Order",
            ),
            Tab(
              icon: Icon(
                Icons.archive,
              ),
              text: "Archive",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrdersSreen(),
          HistoryOrderScreen(),
        ],
      ),
    );
  }
}
