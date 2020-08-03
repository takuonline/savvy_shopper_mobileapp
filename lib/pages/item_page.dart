import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takuonline/pages/cart.dart';
import 'constants.dart';
import 'package:uuid/uuid.dart';
import 'package:takuonline/cart/trolley.dart';

class ItemPage extends StatefulWidget {
  static const id = 'ItemPage';

  AssetImage cardImage;
  String cardName;
  int price;
  int discountedPrice;
  bool isSale;
  String cartID;
  int quantity;

  ItemPage(
      [this.cardImage,
      this.cardName,
      this.price,
      this.discountedPrice,
      this.isSale,
      this.cartID,
      this.quantity = 1]);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int itemCount = 0;
  int itemPrice = 1200;

  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Cart.id);
                    },
                    child: Icon(Icons.shopping_cart)),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: Container(
              child: ListView(
            children: <Widget>[
              Hero(
                tag: widget.cartID,
                child: Container(
                  height: 270,
                  child: Image(
                    image: widget.cardImage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      child: Text(
                        '${widget.cardName}',
                        textAlign: TextAlign.left,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                            fontSize: 30.0),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'R ${oCcy.format(widget.price)}',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 25.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                  ' Nunc ultricies sapien molestie lacus elementum iaculis. Mauris'
                  ' et eros non lacus efficitur ullamcorper.  ',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )),
        ),
        bottomSheet: Container(
          color: kSecondaryColor,
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding:EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * .03),
                child: Container(
//                  width: MediaQuery.of(context).size.width * .4,
                    decoration: BoxDecoration(
                      color: Color(0xffd8d8d8),
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: Padding(
                      padding:EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .015, vertical: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.quantity++;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.add,
                                color: Color(0xff6d6d6d),
                              ),
                            ),
                          ),
                          Padding(
                            padding:EdgeInsets.all(3.0),
                            child: Text(
                              '${widget.quantity}',
                              style: TextStyle(
                                  color: Color(0xff6d6d6d),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (widget.quantity <= 0) {
                                  print('item count is at zero');
                                } else {
                                  widget.quantity--;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Icon(Icons.remove, color: Color(0xff6d6d6d)),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Total Price',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'R ${oCcy.format(widget.price * widget.quantity)}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width*.057),
                      ),
                    ],
                  ),
                  Flexible(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*.06,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              String productId = uuid.v1();

                              itemTrolley.add(
                                Product(
                                    widget.cardImage,
                                    widget.cardName,
                                    widget.price,
                                    widget.discountedPrice,
                                    widget.isSale,
                                    productId,
                                    widget.quantity),
                              );

                            },
                          );
                        },
                        child: Icon(
                          Icons.shop,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width*.115,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
