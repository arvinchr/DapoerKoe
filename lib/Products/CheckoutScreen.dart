import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final cart;
  final sum;

  CheckoutScreen(this.cart, this.sum);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListView.separated(
          itemBuilder: (context, index){
          return ListTile(
            title: Text(cart[index].name),
            trailing: Text("Rp.${cart[index].price}",
              style: TextStyle(color: Colors.black),
            ),
            onTap: (){

            },
          );
        },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: cart.length,
          shrinkWrap: true,
        ),
        Divider(),
        Text("Rp.$sum"),
      ],
    );
  }
}
