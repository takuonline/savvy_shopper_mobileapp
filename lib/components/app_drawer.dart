import 'package:flutter/material.dart';
import 'package:takuonline/pages/cart.dart';
import 'package:takuonline/pages/constants.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kSecondaryColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'My account',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Roboto',
                    fontSize: 30.0),
              ),
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
            ),
            DrawerListTile(
              drawerTitle: Text(
                'Shopping Cart',
                style: TextStyle(fontSize: 18),
              ),
              icon: Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.pushNamed(context, Cart.id);
                // Update the state of the app.
                // ...
              },
            ),
            DrawerListTile(
              drawerTitle: Text('Settings' ,
                style: TextStyle(fontSize: 18),),
              icon: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                // Update the state of the app.
                // ...
              },
            ),
            DrawerListTile(
              drawerTitle: Text('About' ,
                style: TextStyle(fontSize: 18),),
              icon: Icon(Icons.info_outline),
              onTap: () {
                Navigator.pop(context);
                // Update the state of the app.
                // ...
              },
            ),
            DrawerListTile(
              drawerTitle: Text('Close' ,
                style: TextStyle(fontSize: 18),),
              icon: Icon(Icons.close),
              onTap: () {
                Navigator.pop(context);
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  DrawerListTile({this.drawerTitle, this.icon, this.onTap});
  Text drawerTitle;
  Function onTap;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          icon,
          SizedBox(
            width: 40.0,
          ),
          drawerTitle,
        ],
      ),
      onTap: onTap,
    );
  }
}

//class DrawerList extends StatelessWidget {
//  DrawerList({this.drawerTitle,this.icon,this.onTap});
//  Text drawerTitle ;
//  Function onTap;
//  Icon icon;
//
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//
//      title: drawerTitle,
//      onTap: onTap,
//      Icon(
//        icon
//      )
//    );
//  }
//}
