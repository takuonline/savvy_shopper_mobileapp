import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'dart:io';

class WelcomePage extends StatefulWidget {
  static const id = 'WelcomePage';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  AnimationController imageController;
  Animation imageAnimation;

  Animation<Offset> textOffset;
  AnimationController textController;

  AnimationController btnController;
  Animation btnAnimation;
  Animation backgroundAnimation;

  @override
  void initState() {
    super.initState();

    imageController = AnimationController(
      duration: Duration(milliseconds: 3700),
      vsync: this,
    );

    textController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    btnController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    btnController.forward();
    imageController.forward();
    textController.forward();

    btnAnimation = CurvedAnimation(
      parent: btnController,
      curve: Interval(.7, 1.0, curve: Curves.easeIn),
    );

    imageAnimation = CurvedAnimation(
        parent: imageController,
        curve: Interval(.5, .8, curve: Curves.bounceOut));

    textOffset = Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: textController,
      curve: Interval(.8, 1, curve: Curves.elasticOut),
    ));


    imageController.addListener(() {
      backgroundAnimation =
          ColorTween(begin: Colors.white, end: Color(0xffffe2e2)).animate(CurvedAnimation(
            parent: btnController,
            curve: Interval(0.1, 0.4, curve: Curves.elasticOut),
          ));

      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    imageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    sleep( Duration(seconds: 3));
    return SafeArea(
        child: Scaffold(
            backgroundColor: backgroundAnimation.value,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Transform.scale(
                      scale: imageAnimation.value,
                      child: Image(
                        width: 300.0,
                        image: AssetImage('images/welcome_screen.png'),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 30.0,
                    ),
                  ),
                  SlideTransition(
                    position: textOffset,
                    child: Text('Welcome',
                        style:
                            TextStyle(fontSize: 40.0, color: Colors.black87)),
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 40.0,
                    ),
                  ),
                  FadeTransition(
                    opacity: btnAnimation,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MenuPage.id);
                      },
//                    textTheme: ButtonTextTheme.accent,
                      color: Color(0xff8785a2),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          'Start',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
