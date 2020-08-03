import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:takuonline/pages/cart.dart';
import 'package:takuonline/pages/constants.dart';
import 'package:takuonline/components/app_drawer.dart';
import 'package:takuonline/components/my_card.dart';
import 'package:takuonline/cart/trolley.dart';

class MenuPage extends StatefulWidget {
  static const id = 'MenuPage';






  @override
  _MenuPageState createState() => _MenuPageState();
}

int getCount(int count){
  int cartCount= 0;

    cartCount = count;

  return cartCount;
}



class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  AnimationController imageController;

  Animation imageAnimation;
  Animation imageAnimation2;
  Animation imageAnimation3;
  Animation imageAnimation4;
  Animation imageAnimation5;
  Animation imageAnimation6;
  Animation imageAnimation7;
  Animation imageAnimation8;



  @override
  void initState() {
    super.initState();

    imageController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    imageController.forward();



    imageAnimation =
        CurvedAnimation(parent: imageController, curve:Interval(.60, .65, curve: Curves.easeOutBack));

    imageAnimation2 =
        CurvedAnimation(parent: imageController, curve:Interval(.65, .70, curve: Curves.easeOutBack));

    imageAnimation3 =
        CurvedAnimation(parent: imageController, curve:Interval(.70, .75, curve: Curves.easeOutBack));

    imageAnimation4 =
        CurvedAnimation(parent: imageController, curve:Interval(.75, .80, curve: Curves.easeOutBack));

    imageAnimation5 =
        CurvedAnimation(parent: imageController, curve:Interval(.80, .85, curve: Curves.easeOutBack));

    imageAnimation6 =
        CurvedAnimation(parent: imageController, curve:Interval(.85, .90, curve: Curves.easeOutBack));

    imageAnimation7 =
        CurvedAnimation(parent: imageController, curve:Interval(.90, .95, curve: Curves.easeOutBack));

    imageAnimation8 =
        CurvedAnimation(parent: imageController, curve:Interval(.95, 1, curve: Curves.easeIn));



    imageController.addListener(() {
      setState(() {

print(imageAnimation.value);
      });
    });

  }




  @override
  void dispose() {
    super.dispose();

    imageController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Menu page',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .11,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Cart.id);

                  },
                  child: Column(
                    children: <Widget>[
//                      Material(
//                        color: kSecondaryColor,
//                        borderRadius: BorderRadius.all(Radius.circular(100)),
//                        child: Padding(
//                          padding: EdgeInsets.symmetric(horizontal: 4),
//                          child: Text(
//                            '${getCount(itemTrolley.length)}',
//                            style: TextStyle(
//                              fontSize: 12.0,
//                            ),
//                          ),
//                        ),
//                      ),
                      Icon(Icons.shopping_cart),
                    ],
                  ),
                )
              ],
            ),
          ),
          drawer: AppDrawer(),
          body: GridView.count(
            childAspectRatio: 20/25,
            crossAxisCount: 2,
            mainAxisSpacing: MediaQuery.of(context).size.height * .005,

            children: <Widget>[
              Transform.scale(
                scale: imageAnimation.value,
                child: MyCard(AssetImage('images/shoes1.jfif'), 'A shoe', 700, 1500,
                    true),
              ),
              Transform.scale(
                scale: imageAnimation2.value,
                child: MyCard(AssetImage('images/sneakers.png'), 'Another shoe', 1200, 1500,
                    true),
              ),
              Transform.scale(
                scale: imageAnimation3.value,
                child: MyCard(AssetImage('images/shoes2.jfif'), 'A third shoe', 3000,
                    3500, false),
              ),
              Transform.scale(
                scale: imageAnimation4.value,
                child: MyCard(AssetImage('images/shoes3.jfif'), 'This is a shoe again shoe again this is a shoe',
                    1200, 1500, false),
              ),
              Transform.scale(
                scale: imageAnimation5.value,
                child: MyCard(AssetImage('images/shoes4.jfif'), 'even more shoes', 200,
                    500, true),
              ),
              Transform.scale(
                scale: imageAnimation6.value,
                child: MyCard(AssetImage('images/shoes5.jfif'), 'l  love shoes', 1200,
                    1500, false),
              ),
              Transform.scale(
                scale: imageAnimation7.value,
                  child: MyCard(AssetImage('images/shoes.png'), 'A shoe', 1200, 1500, false)),
              Transform.scale(
                scale: imageAnimation8.value,
                child: MyCard(AssetImage('images/shoes6.jfif'), 'A shoe', 200, 500,
                    true),
              ),
              MyCard(
                  AssetImage('images/shoes.png'), 'A shoe', 1200, 1500, false)
            ],
          )),
    );
  }
}
