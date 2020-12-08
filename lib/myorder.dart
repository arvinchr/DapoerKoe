import 'package:UTS/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:UTS/order.dart';

class MyOrder extends StatefulWidget {
  static const String id = 'myorder';

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List<ProductModel> cart = [];
  int sum = 0;

  dynamic userDisplayName = 'User';
  User loggedInUser;
  String namaMenu;
  int Total;

  final _auth = FirebaseAuth.instance;
  var _firebaseFirestore = FirebaseFirestore.instance.collection('moods');

  void streamFirestoreData() {
    _firebaseFirestore.doc(loggedInUser.email).snapshots().listen((event) {
      if (event.data() != null){
        setState(() {
          namaMenu = event.data()['namamenu'];
          Total = event.data()['total'];
        });
      }
    });
  }

  void deleteMoods() async {
    await _firebaseFirestore.doc(loggedInUser.email).delete();
  }

  void initState() {
    super.initState();
    getCurrentUser();
    streamFirestoreData();
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      if (loggedInUser.displayName != null) {
        userDisplayName = loggedInUser.displayName;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.amber,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: IconMenu(
            gambarIcon: Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, MainMenu.id);
          },
        ),
        title: Text(
            "My Order",
          style:
            GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                fontSize: 26,
            ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),

      body: ,
    );
  }
}

class IconMenu extends StatelessWidget{
  final IconData gambarIcon;
  final Color warnaIcon;
  final double sizeIcon;

  const IconMenu({
    Key key,
    this.gambarIcon,
    this.warnaIcon,
    this.sizeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            gambarIcon,
            color: warnaIcon,
            size: sizeIcon,
          )
        ]
    );
  }
}