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
                  Container(
                    height: (mediumContainerHeight / 100) * 60,
                    color: Colors.black,
                  ),
                  Container(
                    height: (mediumContainerHeight / 100) * 20,
                    color: Colors.white,
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
