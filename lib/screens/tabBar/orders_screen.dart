import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/data_streams/category_products_stream.dart';
import 'package:store_app/models/Product.dart';
import 'package:store_app/provider/AppProvider.dart';
import 'package:store_app/widgets/categorries.dart';
import 'package:store_app/widgets/contact_card_widget.dart';
import 'package:store_app/widgets/order_card.dart';
import 'package:store_app/widgets/product_card_widget.dart';

import '../../data_streams/all_products_stream.dart';
import '../../data_streams/favourite_products_stream.dart';
import '../../widgets/products_section.dart';
import '../products_details_screen.dart';

class OrdersSreen extends StatefulWidget {
  OrdersSreen({Key key}) : super(key: key);

  @override
  _OrdersSreenState createState() => _OrdersSreenState();
}

class _OrdersSreenState extends State<OrdersSreen> {
  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();
  final AllProductsStream allProductsStream = AllProductsStream();
   // CategoryProductsStream categoryProductsStream = CategoryProductsStream(p);
/*
*
    for(ProductType p in ProductType.values ){
      if(Provider.of<AppProvider>(context).category==p.toString()){
        categoryProductsStream = CategoryProductsStream(p);
      }
    }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteProductsStream.init();
    allProductsStream.init();
    // categoryProductsStream.init();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    allProductsStream.dispose();
    // categoryProductsStream.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {
      return Container(
        color: Colors.white,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   alignment: Alignment.topCenter,
            //   width: double.infinity,
            //   height: 49,
            //   // margin: EdgeInsetsDirectional.only(start: 5, end: 10, top: 5),
            //   color: Colors.white,
            //   child: Column(
            //     children: [
            //       Categories(),
            //       SizedBox(height: 15,),
            //       Container(width: 130,height: 5,color: Colors.blue.withOpacity(0.5),),
            //
            //     ],
            //   ),
            // ),
            Column(
              children: [
                Categories(),
                Container(
                  width: 130,
                  height: 5,
                  color: Colors.blue.withOpacity(0.5),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 198,
                  color: Colors.white,
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    children: [
                      MainOrderCard(
                        image: 'images/bag.png',
                      ),
                      MainOrderCard(
                        image: 'images/bag.png',
                      ),
                      MainOrderCard(
                        image: 'images/bag.png',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsetsDirectional.only(start: 39, end: 39, top: 289),
              color: Colors.transparent,
              child: ProductsSection(
                sectionTitle: "Explore All Products",
                productsStreamController: allProductsStream,
                emptyListMessage: "Looks like all Stores are closed",
                onProductCardTapped: onProductCardTapped,
              ),
              // child: GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, "/homeCartScreen");
              //   },
              //   // child: RefreshIndicator(
              //   //   child: ListView.builder(itemBuilder: (context,index){}),
              //   // ),
              //   // child: provider.allProduct == null
              //   //     ? Center(
              //   //         child: CircularProgressIndicator(),
              //   //       )
              //   //     : provider.allProduct.isEmpty
              //   //         ? Center(
              //   //             child: Text('No Products Found'),
              //   //           )
              //   //         : ListView.builder(
              //   //             itemCount: provider.allProduct.length,
              //   //             itemBuilder: (context, index) {
              //   //               return ProductCard(
              //   //                   image: provider.allProduct[index].image_url,
              //   //                   order_name: provider.allProduct[index].name,
              //   //                   add_to_cart: false,
              //   //                   order_price:
              //   //                       '${provider.allProduct[index].price}"\$"');
              //   //             },
              //   //           ),
              //   child: GridView(
              //
              //       scrollDirection: Axis.vertical,
              //       padding: EdgeInsets.all(5),
              //       gridDelegate:
              //           SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 2,
              //               crossAxisSpacing: 10,
              //               mainAxisSpacing: 10),
              //       children: [
              //         ProductCard(
              //             image: 'images/main_order.png',
              //             order_name: 'Hand bags',
              //             add_to_cart: false,
              //             order_price: '100"\$"'),
              //         ProductCard(
              //             image: 'images/main_order.png',
              //             order_name: 'Hand bags',
              //             add_to_cart: true,
              //             order_price: '100"\$"'),
              //         ProductCard(
              //             image: 'images/main_order.png',
              //             order_name: 'Hand bags',
              //             add_to_cart: false,
              //             order_price: '100"\$"'),
              //         ProductCard(
              //             image: 'images/main_order.png',
              //             order_name: 'Hand bags',
              //             add_to_cart: true,
              //             order_price: '100"\$"'),
              //         ProductCard(
              //             image: 'images/main_order.png',
              //             order_name: 'Hand bags',
              //             add_to_cart: false,
              //             order_price: '100"\$"'),
              //         ProductCard(
              //             image: 'images/main_order.png',
              //             order_name: 'Hand bags',
              //             add_to_cart: false,
              //             order_price: '100"\$"'),
              //       ],
              //     ),
              // ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> refreshPage() {
    favouriteProductsStream.reload();
    allProductsStream.reload();
    return Future<void>.value();
  }
  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDtails(productId: productId),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }

}
