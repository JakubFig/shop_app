import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(children: <Widget>[
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount}',
                    style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .titleLarge!
                            .color),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Order Now'),
                  //style: TextButton.styleFrom(primary: Color(value)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => CartItem(
              cart.items.values.toList()[index].id,
              cart.items.values.toList()[index].price,
              cart.items.values.toList()[index].qunatity,
              cart.items.values.toList()[index].title,
            ),
            itemCount: cart.items.length,
          ),
        )
      ]),
    );
  }
}
