import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


final oCcy = new NumberFormat("#,##0.00", "en_US");

class Product{
  AssetImage productImage;
  String productName;
  int price;
  int discountedPrice;
  bool isSale;
  String cartID;
  int quantity;


  Product(
      [this.productImage,
      this.productName,
      this.price,
      this.discountedPrice,
      this.isSale = false,
      this.cartID ,
      this.quantity= 1]);
}


List itemTrolley = [];