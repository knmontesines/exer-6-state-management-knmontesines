import 'package:flutter/material.dart';
import '../../model/Item.dart';
import "package:provider/provider.dart";
import '../../provider/shoppingcart_provider.dart';

class Checkout extends StatelessWidget {
    const Checkout({super.key});
    
    @override
    Widget build(BuildContext context) {
      List<Item> products = context.watch<ShoppingCart>().cart;
      return Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Item Details"),
          const Divider(height: 4, color: Colors.black),
          listItems(context),
          products.isNotEmpty                                                            // check if the cart is empty, if it is not empty then it will call computeCost()
                            ?
          computeCost():
          const Divider(height: 4, color: Colors.black),
          Flexible(
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [ 
                            products.isEmpty                                            // check if the cart is empty, if it is empty, then it will display that 'No items to checkout'
                            ? Text('No items to checkout!'):
                            ElevatedButton(                                             // Button for 'Pay Now'
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/products");            // If pressed, it will return to the MyCatalog page
                                  context.read<ShoppingCart>().removeAll();             // If pressed, it will set the cart and total cost to zero
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Payment Successful!"),                                     // A snackbar will display in the MyCatalog page saying that 'Payment Successful'
              duration: const Duration(seconds: 3, milliseconds: 100),
            ));
                                },
                                child: const Text("Pay Now", style: TextStyle(color: Colors.white)),
                                )
                    ]
                    )
                    )
                    ),
          ],
        ),
      );
    }

    Widget computeCost() {
        return Consumer<ShoppingCart>(builder: (context, cart, child) {
            return Text("Total Cost to Pay: ${cart.cartTotal}");                        // computes and displays the total cost in the cart and to be paid
        });
      }

    Widget listItems(BuildContext context) {
      List<Item> products = context.watch<ShoppingCart>().cart; 
          return Expanded(
              child: Column(
              children: [
                Flexible(
                    child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("${products[index].name}  ${products[index].price}"), // displays the name and price of the product to be paid in the checkout page
                    );
                  },
                )),
              ],
            ));
          }
        }