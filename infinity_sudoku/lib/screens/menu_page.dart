import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double topSizeBoxHeight = (screenHeight / 100) * 5;
    final double mediumSizeBoxHeight = (screenHeight / 100) * 10;
    final double bottomSizeBoxHeight = (screenHeight / 100) * 10;
    final double topContainerHeight = (screenHeight / 100) * 10;
    final double mediumContainerHeight = (screenHeight / 100) * 40;
    final double bottomContainerHeight = (screenHeight / 100) * 15;

    return Scaffold(
      backgroundColor: Colors.pink,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: topSizeBoxHeight,
            ),
            Container(
              height: topContainerHeight,
              color: Colors.green,
            ),
            SizedBox(
              height: mediumSizeBoxHeight,
            ),
            Container(
              height: mediumContainerHeight,
              color: Colors.amber,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: (mediumContainerHeight / 100) * 60,
                        height: (mediumContainerHeight / 100) * 60,
                        //color: Colors.blue,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(200)),
                      ),
                      Positioned(
                          left: 75,
                          top: 50,
                          child: Container(
                            width: 10,
                            height: 100,
                            color: Colors.red,
                          )),
                      Positioned(
                          left: 125,
                          top: 50,
                          child: Container(
                            width: 10,
                            height: 100,
                            color: Colors.red,
                          )),
                      Positioned(
                          left: 50,
                          top: 75,
                          child: Container(
                            width: 100,
                            height: 10,
                            color: Colors.red,
                          )),
                      Positioned(
                          left: 50,
                          top: 125,
                          child: Container(
                            width: 100,
                            height: 10,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  Container(
                    height: (mediumContainerHeight / 100) * 20,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                        ),
                        Container(
                          height: (mediumContainerHeight / 100) * 20,
                          width: 200,
                          color: Colors.black,
                        ),
                        Container(
                          width: 100,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: (mediumContainerHeight / 100) * 20,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: bottomSizeBoxHeight,
            ),
            Container(
              height: bottomContainerHeight,
              color: Colors.blue,
            ),
            SizedBox(
              height: bottomSizeBoxHeight,
            ),
          ],
        ),
      ),
    );
  }
}
