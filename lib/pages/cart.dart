import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:takuonline/cart/trolley.dart';
import 'dart:io';

class Cart extends StatefulWidget {
  static const id = 'Cart';

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with TickerProviderStateMixin {
  AnimationController imageController;

  Animation imageAnimation;
  var minusBtnColor = kSecondaryColor;

  @override
  void initState() {
    super.initState();

    imageController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    imageController.forward();

    imageAnimation = CurvedAnimation(
        parent: imageController,
        curve: Interval(0.1, .3, curve: Curves.easeOutBack));

    imageController.addListener(() {
      setState(() {
        print(imageAnimation.value);
      });
    });
  }

  List<Widget> getTrolleyItems() {
    List<Widget> itemsBought = [];

    for (var i in itemTrolley) {
      Product trolley = i;

      var name = 'imageAnimation+${i.toString()})';
      print(name);

      itemsBought.add(Transform.scale(
        scale: imageAnimation.value,
        child: cartCard(
            cartPrice: trolley.price,
            cartName: trolley.productName,
            cartImage: trolley.productImage,
            discountedPrice: trolley.discountedPrice,
            isSale: trolley.isSale,
            cartID: trolley.cartID,
            quantity: trolley.quantity),
      ));
    }
    return itemsBought;
  }

  int getTotal(List itemTrolley) {
    int total = 0;
    for (var x in itemTrolley) {
      total = total + x.quantity * x.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Center(
            child: Text(
              'Cart',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30.0,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              0, 0, 0, MediaQuery.of(context).size.height * .1),
          child: ListView(
            children: getTrolleyItems() ??
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      'The cart is empty',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black12, fontSize: 50),
                    ),
                  ),
                ),
          ),
        ),
        bottomSheet: Container(
          height: MediaQuery.of(context).size.height * .10,
          color: kSecondaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * .025,
                horizontal: MediaQuery.of(context).size.width * .055),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.width * .055,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal:
                                  MediaQuery.of(context).size.width * .11),
                          child: Text(
                            'Buy',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0),
                          ),
                        ),
                        color: Colors.black,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'R${oCcy.format(getTotal(itemTrolley)) ?? 0}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Dismissible cartCard(
      {int cartPrice,
      String cartName,
      AssetImage cartImage,
      int discountedPrice,
      bool isSale,
      String cartID,
      int quantity}) {
    return Dismissible(
      key: Key(cartID),
      onDismissed: (direction) {
        print(direction);

        setState(() {
          itemTrolley.removeWhere((item) => item.cartID == cartID);
        });
      },
      background: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          color: Colors.white10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                color: Colors.white,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          )),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 20.0,
        shadowColor: Colors.black,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          child: Container(
            height: 150.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
//                    padding: EdgeInsets.all(5.0),
                    child: Image(
                      width: 120,
                      image: cartImage,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          cartName,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: MediaQuery.of(context).size.width * .055,
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 20,
                          ),
                        ),
                        Text(
                          'R ${oCcy.format(cartPrice)}',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 50.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            additionButton(cartID),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                '${getItemQuantity(cartID)}',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 20.0),
                              ),
                            ),
                            subtractionButton(cartID),
                            SizedBox(width: 5.0),
                            closingButton(cartID, context)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getItemQuantity(String cartID) {
    for (var item in itemTrolley) {
      if (item.cartID == cartID) {
        return item.quantity;
      }
    }
  }

  GestureDetector additionButton(String cartID) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (var item in itemTrolley) {
            if (item.cartID == cartID) {
              item.quantity++;
            }
          }
        });
      },
      child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .01),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(Icons.add)),
    );
  }

  GestureDetector subtractionButton(String cartID) {
    return GestureDetector(

      onTap: () {
        setState(() {
          for (var item in itemTrolley) {
            if (item.cartID == cartID) {
              if (item.quantity > 0) {
                item.quantity--;
              }
            }
          }
        });
      },
      child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .01),
          decoration: BoxDecoration(
            color: minusBtnColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(Icons.remove)),
    );
  }

  GestureDetector closingButton(String cartID, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          itemTrolley.removeWhere((item) => item.cartID == cartID);
//          Scaffold
//              .of(context)
//              .showSnackBar(SnackBar(content: Text("Removed item from cart")));
        });
      },
      child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .01),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            Icons.close,
            color: Colors.white,
          )),
    );
  }
}
