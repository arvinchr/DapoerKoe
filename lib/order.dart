import 'package:UTS/Products/CheckoutScreen.dart';
import 'package:UTS/menu.dart';
import 'package:UTS/myorder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderMenu extends StatefulWidget{
  static const String id = 'order';

  @override
  _OrderMenu createState() => _OrderMenu();
}

class _OrderMenu extends State<OrderMenu> {
  List<ProductModel> cart = [];
  int sum = 0;
  String namaMenu;
  int jumlah;

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.amber,

          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pushNamed(context, MainMenu.id);
              },
            ),

            title: Text(
              'Order',
              style:
              GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  fontSize: 26
              ),
            ),

            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Menu",
                    style:
                    GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Checkout",
                    style:
                    GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.bold,
                        fontSize: 22
                    ),
                  ),
                ),
              ],
            ),

            actions: [
              IconButton(
                icon: Icon(
                  Icons.view_list,
                  color: Colors.white,
                ),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, MyOrder.id);
                },
              )
            ],
          ),

          body: TabBarView(
              children: <Widget>[
                ProductScreen((selectedProduct) {
                  setState(() {
                    cart.add(selectedProduct);
                    sum = 0;
                    cart.forEach((item) {
                      sum = sum + item.price;
                    });
                    namaMenu = products;
                  });
                }),
                CheckoutScreen(cart, sum),
              ],
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () async {
              var loggedInUser = FirebaseAuth.instance.currentUser;
              await firestoreInstance.collection('Order').doc(
                  loggedInUser.email).set(
                  {
                    'namamenu': Text("${products[index].name}"),
                    'Total': '$sum',
                  });
            },
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductModel{
  String name;
  int price;

  ProductModel(String name, int price){
    this.name = name;
    this.price = price;
  }
}

class ProductScreen extends StatelessWidget {
  final ValueSetter<ProductModel> _valueSetter;

  ProductScreen(this._valueSetter);

  final List<ProductModel> products = [
    ProductModel("Rendang", 16000),
    ProductModel("Mie Goreng", 13000),
    ProductModel("Ayam Pop", 14000),
    ProductModel("Telur Balado", 7000),
  ];

  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index].name),
          trailing: Text("Rp. ${products[index].price}",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            _valueSetter(products[index]);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: products.length,
    );
  }
}