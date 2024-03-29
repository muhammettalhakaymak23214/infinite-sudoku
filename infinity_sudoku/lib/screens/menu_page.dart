import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:infinity_sudoku/consts/colors.dart';
import 'package:infinity_sudoku/screens/game_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Color _primaryColor = Colors.black;
  Color _secondaryColor = Colors.white;
  bool _isMenuOpen = false;
  List<String> oyunModu = ["Kolay", "Orta", "Zor"];
  int i = 0;
  String oyunModuTercihi = "Kolay";

  @override
  void initState() {
    _loadSelectedColor();
    super.initState();
  }

  Future<void> _loadSelectedColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('birincilRenk');
    int? colorValue2 = prefs.getInt('ikincilRenk');
    if (colorValue != null && colorValue2 != null) {
      setState(() {
        _primaryColor = Color(colorValue);
        _secondaryColor = Color(colorValue2);
      });
    } else {
      //Varsayılan renkler
      _primaryColor = Colors.blue;
      _secondaryColor = Colors.blue;
    }
  }

  Future<void> _saveSelectedColor(String colorKey, int colorValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(colorKey, colorValue);
  }

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
      backgroundColor: _primaryColor,
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: topSizeBoxHeight,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: topContainerHeight,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isMenuOpen = !_isMenuOpen;
                        });
                      },
                      icon: const Icon(Icons.palette),
                      color: _secondaryColor),
                ),
                SizedBox(
                  height: mediumSizeBoxHeight,
                ),
                Container(
                  height: mediumContainerHeight,
                  // color: _primaryColor,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: circuluarWidth,
                            height: circuluarHeight,
                            decoration: BoxDecoration(
                                color: _secondaryColor,
                                borderRadius: BorderRadius.circular(200)),
                          ),
                          Positioned(
                              left: circuluarWidth / 3,
                              top: circuluarHeight / 4,
                              child: Container(
                                width: cizgikalinligi,
                                height: circuluarHeight / 2,
                                decoration: BoxDecoration(
                                    color: _primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                          Positioned(
                              left: ((circuluarWidth / 3) * 2) - cizgikalinligi,
                              top: circuluarHeight / 4,
                              child: Container(
                                width: cizgikalinligi,
                                height: circuluarHeight / 2,
                                decoration: BoxDecoration(
                                    color: _primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                          Positioned(
                              left: circuluarWidth / 4,
                              top: circuluarHeight / 3,
                              child: Container(
                                width: circuluarWidth / 2,
                                height: cizgikalinligi,
                                decoration: BoxDecoration(
                                    color: _primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                          Positioned(
                              left: circuluarWidth / 4,
                              top: ((circuluarHeight / 3) * 2) - cizgikalinligi,
                              child: Container(
                                width: circuluarWidth / 2,
                                height: cizgikalinligi,
                                decoration: BoxDecoration(
                                    color: _primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                        ],
                      ),
                      Container(
                        height: (mediumContainerHeight / 100) * 20,
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth / 4,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: _secondaryColor),
                                onPressed: () {
                                  setState(() {
                                    i--;
                                  });
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: (mediumContainerHeight / 100) * 15,
                              width: screenWidth / 2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                oyunModu[i % 3],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30, color: _secondaryColor),
                              ),
                            ),
                            Container(
                              width: screenWidth / 4,
                              // color: const Color.fromARGB(255, 7, 255, 160),
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios,
                                    color: _secondaryColor),
                                onPressed: () {
                                  setState(() {
                                    i++;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          oyunModuTercihi = oyunModu[i % 3];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GamePage(
                                      oyunModuTercihi: oyunModuTercihi)));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          height: ((mediumContainerHeight / 100) * 20) - 20,
                          width: (screenWidth / 7) * 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: _secondaryColor, width: 2)),
                          child: Text(
                            "Oyna",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 30, color: _secondaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: bottomSizeBoxHeight,
                ),
                Container(
                  margin: EdgeInsets.all(30),
                  height: bottomContainerHeight - 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              size: 40,
                              color: _secondaryColor,
                            )),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            size: 40,
                            color: _secondaryColor,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.warning,
                            size: 40,
                            color: _secondaryColor,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: bottomSizeBoxHeight,
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 63,
            right: _isMenuOpen ? 0 : (-screenWidth * 1.2),
            child: Container(
              width: screenWidth * 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: colorPrimary1,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {
                        changeColor(colorPrimary1, colorSecondary1);
                      },
                      icon: const Icon(Icons.circle_outlined),
                      color: colorSecondary1,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: colorPrimary2,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {
                        changeColor(colorPrimary2, colorSecondary2);
                      },
                      icon: const Icon(Icons.circle_outlined),
                      color: colorSecondary2,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: colorPrimary3,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {
                        changeColor(colorPrimary3, colorSecondary3);
                      },
                      icon: const Icon(Icons.circle_outlined),
                      color: colorSecondary3,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: colorPrimary4,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {
                        changeColor(colorPrimary4, colorSecondary4);
                      },
                      icon: const Icon(Icons.circle_outlined),
                      color: colorSecondary4,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: colorPrimary5,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {
                        changeColor(colorPrimary5, colorSecondary5);
                      },
                      icon: const Icon(Icons.circle_outlined),
                      color: colorSecondary5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeColor(Color primaryColor, Color secondaryColor) {
    _primaryColor = primaryColor;
    _secondaryColor = secondaryColor;
    if (_primaryColor != null) {
      _saveSelectedColor("birincilRenk", _primaryColor.value);
      _saveSelectedColor("ikincilRenk", _secondaryColor.value);
      _loadSelectedColor();
    }
  }
}
