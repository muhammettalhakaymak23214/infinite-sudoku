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
    final double circuluarHeight = (mediumContainerHeight / 100) * 60;
    final double circuluarWidth = circuluarHeight;
    final double cizgikalinligi = circuluarWidth / 20;
    final double cizgiuzunlugu = circuluarWidth / 3;

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
                        width: circuluarWidth,
                        height: circuluarHeight,
                        //color: Colors.blue,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(200)),
                      ),
                      Positioned(
                          left: circuluarWidth / 3,
                          top: circuluarHeight / 4,
                          child: Container(
                            width: cizgikalinligi,
                            height: circuluarHeight / 2,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                          )),
                      Positioned(
                          left: ((circuluarWidth / 3) * 2) - cizgikalinligi,
                          top: circuluarHeight / 4,
                          child: Container(
                            width: cizgikalinligi,
                            height: circuluarHeight / 2,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                          )),
                      Positioned(
                          left: circuluarWidth / 4,
                          top: circuluarHeight / 3,
                          child: Container(
                            width: circuluarWidth / 2,
                            height: cizgikalinligi,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                          )),
                      Positioned(
                          left: circuluarWidth / 4,
                          top: ((circuluarHeight / 3) * 2) - cizgikalinligi,
                          child: Container(
                            width: circuluarWidth / 2,
                            height: cizgikalinligi,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                          )),
                    ],
                  ),
                  Container(
                    height: (mediumContainerHeight / 100) * 20,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth / 4,
                          color: const Color.fromARGB(255, 7, 255, 160),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: (mediumContainerHeight / 100) * 15,
                          width: screenWidth / 2,
                          color: const Color.fromARGB(255, 255, 1, 1),
                          child: const Text(
                            "Kolay",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Container(
                          width: screenWidth / 4,
                          color: const Color.fromARGB(255, 7, 255, 160),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    height: ((mediumContainerHeight / 100) * 20) - 20,
                    width: (screenWidth / 3) * 2,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 1, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Oyna",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
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
