import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:takuonline/pages/cart.dart';
import 'package:takuonline/pages/constants.dart';
import 'package:takuonline/pages/item_page.dart';
import 'package:takuonline/pages/menu_page.dart';
import 'package:uuid/uuid.dart';
import 'package:takuonline/cart/trolley.dart';

class MyCard extends StatefulWidget {
  final AssetImage productImage;
  final String productName;
  final int price;
  final int discountedPrice;
  final bool isSale;
  final int quantity;
//  final int heroID;

  MyCard([
//    this.heroID,
    this.productImage,
    this.productName,
    this.price,
    this.discountedPrice,
    this.isSale = false,
    this.quantity = 1,
  ]);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  Row getSale(bool isSale) {
    Row answer = isSale
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Transform.translate(
                offset: Offset(17, 0),
                child: Transform.rotate(
                  angle: 32.05,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.red,
                    child: Text(
                      'Sale',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row();
    return answer;
  }

  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
    String productId = uuid.v1();

    return Card(
      shadowColor: Colors.white,
      color: Colors.white,
      elevation: 10,
      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * .02,
          10, MediaQuery.of(context).size.width * .015, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ItemPage(
                  widget.productImage,
                  widget.productName,
                  widget.price,
                  widget.discountedPrice,
                  widget.isSale,
                  productId,
                  widget.quantity,
                );
              }));
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
//              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                getSale(widget.isSale),
                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: '$productId',
                      child: Image(image: widget.productImage),
                    ),
                  ),
                ),
//                Expanded(
//                  flex: 1,
//                  child: SizedBox(
//                    height: 10,
//                  ),
//                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'R${oCcy.format(widget.discountedPrice)}',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,fontSize: MediaQuery.of(context).size.width * .031),
                        ),
                      ),
                      Text(
                        'R${oCcy.format(widget.price)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          widget.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.black54, fontSize: MediaQuery.of(context).size.width * .042),
                        ),
                      ),
                      addButton(context, productId)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector addButton(BuildContext context, String productId) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          duration: Duration(milliseconds: 700),
          content: Text('Item added to cart'),
          action: SnackBarAction(
            label: 'Cart',
            onPressed: () {
              Navigator.pushNamed(context, Cart.id);
            },
          ),
        );

        Scaffold.of(context).showSnackBar(snackBar);

        setState(() {
          itemTrolley.add(Product(
            widget.productImage,
            widget.productName,
            widget.price,
            widget.discountedPrice,
            widget.isSale,
            productId,
//                        widget.heroID
          ));
        });
      },
      child: Material(
        color: kSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
