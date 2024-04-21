import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:infinity_sudoku/consts/colors.dart';

import 'package:infinity_sudoku/screens/game_page.dart';
import 'package:infinity_sudoku/screens/hakk%C4%B1imda_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:vibration/vibration.dart'; //
import 'dart:async';

class MenuPage extends StatefulWidget {
  //
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class NotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initialize() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // Gerekli diğer ayarlamaları yapın
  }

  Future<void> showNotification() async {
    var android = AndroidNotificationDetails('channel_id', 'channel_name');

    var platform = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(0, 'Başlık', 'İçerik', platform,
        payload: 'Bildirim payload');
  }
}

class _MenuPageState extends State<MenuPage> {
  final NotificationService notificationService = NotificationService();
  double ortalamaSayiSureSudokuYazilacak = 0;
  double ortalamaSayiSureSudoku = 0;
  int cozulenSudokuSuresi = 0;
  int cozulenSudokuSayisi = 0;
  Color _primaryColor = Colors.black;
  Color _secondaryColor = Colors.white;
  bool _isMenuOpen = false;
  List<String> oyunModu = ["Kolay", "Orta", "Zor"];
  int i = 0;
  String oyunModuTercihi = "Kolay";

  bool isSwitchedBildirim = false;
  bool sesDurumu = false;
  bool titresimDurumu = false;

  @override
  void initState() {
    _loadSelectedColor();
    _getirSecilenSes();
    _getirSecilenTitresim();
    super.initState();
  }

  void titresimCal() async {
    // Telefonun titreşim özelliğinin bulunup bulunmadığını kontrol et
    bool? hasVibrator = await Vibration.hasVibrator();

    // hasVibrator değeri null değilse ve true ise, titreşimi başlat
    if ((hasVibrator == true) && (titresimDurumu == true)) {
      Vibration.vibrate(duration: 100);
    }
  }

  void sesCal() {
    if (sesDurumu == true) {
      final player = AudioPlayer();
      player.play(AssetSource('ses.mp3'));
    }
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

  Future<void> _kaydetSecilenSes(bool secilenSesDurumu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sesDurumu', secilenSesDurumu);
    sesDurumu = prefs.getBool('sesDurumu') ?? false;
  }

  Future<void> _getirSecilenSes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sesDurumu = prefs.getBool('sesDurumu') ?? false;
  }

  Future<void> _kaydetSecilenTitresim(bool secilenTitresimDurumu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('titresimDurumu', secilenTitresimDurumu);
    titresimDurumu = prefs.getBool('titresimDurumu') ?? false;
  }

  Future<void> _getirSecilenTitresim() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    titresimDurumu = prefs.getBool('titresimDurumu') ?? false;
  }

  Future<void> _saveSelectedColor(String colorKey, int colorValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(colorKey, colorValue);
  }

  _loadSavedSudokuCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cozulenSudokuSayisi = prefs.getInt('cozulenSudokuSayisi') ?? 0;
    });
  }

  _loadSavedSudokuSuresi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cozulenSudokuSuresi = prefs.getInt('cozulenSudokuSuresi') ?? 0;
      ortalamaSayiSureSudoku = cozulenSudokuSuresi / cozulenSudokuSayisi;
    });
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

    final double ortaContainer = (screenHeight / 100) * 50;

    @override
    Future<void> _istatistikler(BuildContext context) async {
      final double screenHeight = MediaQuery.of(context).size.height;
      final double screenWidth = MediaQuery.of(context).size.width;
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.80),
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: _secondaryColor, width: 2.0),
            ),
            backgroundColor: _primaryColor,
            title: Text(
              'İstatistikler',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: (screenHeight / 100) * 3),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(color: Colors.white),
                  SizedBox(height: 20),
                  Container(
                    height: (screenHeight / 100) * 5,
                    width: (screenWidth / 100) * 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _secondaryColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white)),
                    child: Text(
                      'Çözülen Sudoku Sayısı: $cozulenSudokuSayisi',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenHeight / 100) * 1.5),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight / 100) * 2,
                  ),
                  Container(
                    height: (screenHeight / 100) * 5,
                    width: (screenWidth / 100) * 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _secondaryColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white)),
                    child: Text(
                      'Geçirilen Zaman: $cozulenSudokuSuresi Saniye',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenHeight / 100) * 1.5),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight / 100) * 2,
                  ),
                  Container(
                    height: (screenHeight / 100) * 5,
                    width: (screenWidth / 100) * 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _secondaryColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white)),
                    child: Text(
                      'Ortalama Sudoku Çözme Süresi: ${ortalamaSayiSureSudoku.toStringAsFixed(2)} Saniye',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenHeight / 100) * 1.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    @override
    Future<void> _hakkimda(BuildContext context) async {
      final double screenHeight = MediaQuery.of(context).size.height;
      final double screenWidth = MediaQuery.of(context).size.width;
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.80),
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: _secondaryColor, width: 2.0),
            ),
            backgroundColor: _primaryColor,
            title: Text(
              'İstatistikler',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: (screenHeight / 100) * 3),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(color: Colors.white),
                  SizedBox(height: 20),
                  Container(
                    height: (screenHeight / 100) * 5,
                    width: (screenWidth / 100) * 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _secondaryColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white)),
                    child: Text(
                      'Çözülen Sudoku Sayısı: 123',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenHeight / 100) * 1.5),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight / 100) * 2,
                  ),
                  Container(
                    height: (screenHeight / 100) * 5,
                    width: (screenWidth / 100) * 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _secondaryColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white)),
                    child: Text(
                      'Geçirilen Zaman: 123',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenHeight / 100) * 1.5),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight / 100) * 2,
                  ),
                  Container(
                    height: (screenHeight / 100) * 5,
                    width: (screenWidth / 100) * 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: _secondaryColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white)),
                    child: Text(
                      'Ortalama Sudoku Çözme Süresi: 123',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenHeight / 100) * 1.5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    void guncelle(setState) {
      setState(() {});
    }

    @override
    Future<void> _ayarlar(BuildContext context) async {
      final double screenHeight = MediaQuery.of(context).size.height;
      final double screenWidth = MediaQuery.of(context).size.width;
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.80),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: _secondaryColor, width: 2.0),
              ),
              backgroundColor: _primaryColor,
              title: Text(
                'Ayarlar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: (screenHeight / 100) * 3),
              ),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Divider(color: Colors.white),
                    SizedBox(height: 20),
                    /*
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bildirimler : ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (screenHeight / 100) * 1.5),
                        ),
                        Switch(
                          value: isSwitchedBildirim,
                          onChanged: (value) {
                            sesCal();
                            titresimCal();
                            isSwitchedBildirim = value;
                            guncelle(setState);
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    )),
                    SizedBox(
                      height: (screenHeight / 100) * 2,
                    ),*/
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ses : ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (screenHeight / 100) * 1.5),
                        ),
                        Switch(
                          value: sesDurumu,
                          onChanged: (value) {
                            sesCal();
                            titresimCal();
                            sesDurumu = value;
                            _kaydetSecilenSes(value);
                            guncelle(setState);
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    )),
                    SizedBox(
                      height: (screenHeight / 100) * 2,
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Titreşim : ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: (screenHeight / 100) * 1.5),
                        ),
                        Switch(
                          value: titresimDurumu,
                          onChanged: (value) {
                            sesCal();
                            titresimCal();
                            titresimDurumu = value;
                            _kaydetSecilenTitresim(titresimDurumu);
                            guncelle(setState);
                          },
                          activeTrackColor: Colors.lightGreenAccent,
                          activeColor: Colors.green,
                        ),
                      ],
                    )),
                    SizedBox(
                      height: (screenHeight / 100) * 2,
                    ),
                  ],
                ),
              ),
            );
          });
        },
      );
    }

    return Scaffold(
      backgroundColor: _primaryColor,
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: (screenHeight / 100) * 5,
                ),
                Container(
                  //   color: Colors.amber,
                  alignment: Alignment.centerRight,
                  height: topContainerHeight,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isMenuOpen = !_isMenuOpen;
                          NotificationService().initialize();
                          // _showNotification();
                          sesCal();
                          titresimCal();
                        });
                      },
                      icon: Container(
                          height: (screenWidth / 100) * 12,
                          width: (screenWidth / 100) * 12,
                          margin: EdgeInsets.only(
                              right: (screenHeight / 100) * 2.5),
                          decoration: BoxDecoration(
                              color: _secondaryColor,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Icon(
                            Icons.palette,
                            size: (screenWidth / 100) * 6,
                            color: Colors.white,
                          )),
                      color: _secondaryColor),
                ),
                SizedBox(
                  height: (screenHeight / 100) * 6,
                ),
                Container(
                  height: ortaContainer,
                  //color: _primaryColor,
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.pink,
                        height: (ortaContainer / 100) * 50,
                        child: Stack(
                          children: [
                            Container(
                              // ?-------------------------------------
                              width: circuluarWidth,
                              height: circuluarHeight,
                              decoration: BoxDecoration(
                                  color: _secondaryColor,
                                  borderRadius: BorderRadius.circular(200),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      width: 2)),
                            ),
                            Positioned(
                                left: circuluarWidth / 3,
                                top: circuluarHeight / 4,
                                child: Container(
                                  width: cizgikalinligi,
                                  height: circuluarHeight / 2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255))),
                                )),
                            Positioned(
                                left:
                                    ((circuluarWidth / 3) * 2) - cizgikalinligi,
                                top: circuluarHeight / 4,
                                child: Container(
                                  width: cizgikalinligi,
                                  height: circuluarHeight / 2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255))),
                                )),
                            Positioned(
                                left: circuluarWidth / 4,
                                top: circuluarHeight / 3,
                                child: Container(
                                  width: circuluarWidth / 2,
                                  height: cizgikalinligi,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255))),
                                )),
                            Positioned(
                                left: circuluarWidth / 4,
                                top: ((circuluarHeight / 3) * 2) -
                                    cizgikalinligi,
                                child: Container(
                                  width: circuluarWidth / 2,
                                  height: cizgikalinligi,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255))),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (ortaContainer / 100) * 10,
                      ),
                      Container(
                        // color: Colors.blue,
                        // margin: EdgeInsets.only(bottom: 20),
                        height: (ortaContainer / 100) * 15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: (ortaContainer / 100) * 12,
                                decoration: BoxDecoration(
                                    color: _secondaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                                width: screenWidth / 8,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: (screenHeight / 100) * 3),
                                  onPressed: () {
                                    setState(() {
                                      sesCal();
                                      titresimCal();
                                      i--;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: (ortaContainer / 100) * 12,
                              width: screenWidth / 3,
                              decoration: BoxDecoration(
                                  color: _secondaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: Text(
                                oyunModu[i % 3],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: (screenHeight / 100) * 3,
                                    color: Colors.white),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: (ortaContainer / 100) * 12,
                                decoration: BoxDecoration(
                                    color: _secondaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                                width: screenWidth / 8,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: (screenHeight / 100) * 3),
                                  onPressed: () {
                                    setState(() {
                                      sesCal();
                                      titresimCal();
                                      i--;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: (ortaContainer / 100) * 3,
                      ),
                      GestureDetector(
                        onTap: () {
                          sesCal();
                          titresimCal();
                          oyunModuTercihi = oyunModu[i % 3];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GamePage(
                                        oyunModuTercihi: oyunModuTercihi,
                                        birincilRenk: _primaryColor,
                                        ikincilRenk: _secondaryColor,
                                      )));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          height: (ortaContainer / 100) * 12,
                          width: (screenWidth / 7) * 6,
                          decoration: BoxDecoration(
                              color: _secondaryColor,
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Text(
                            "Oyna",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: (screenHeight / 100) * 3,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: (screenHeight / 100) * 15,
                ),
                Container(
                  // color: Colors.amber,
                  // margin: EdgeInsets.all(30),
                  height: (screenHeight / 100) * 9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //----------------
                        },
                        child: Container(
                          height: (screenWidth / 100) * 12,
                          width: (screenWidth / 100) * 12,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: _secondaryColor,
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                              onPressed: () {
                                sesCal();
                                titresimCal();
                                _ayarlar(context);
                              },
                              icon: Icon(
                                Icons.settings,
                                size: (screenHeight / 100) * 3,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //----------------
                        },
                        child: Container(
                          height: (screenWidth / 100) * 12,
                          width: (screenWidth / 100) * 12,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: _secondaryColor,
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                              onPressed: () {
                                sesCal();
                                titresimCal();
                                // cozulenSudokuSayisi
                                _loadSavedSudokuCount();
                                _loadSavedSudokuSuresi();
                                _istatistikler(context);
                              },
                              icon: Icon(
                                Icons.menu,
                                size: (screenHeight / 100) * 3,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //----------------
                        },
                        child: Container(
                          height: (screenWidth / 100) * 12,
                          width: (screenWidth / 100) * 12,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: _secondaryColor,
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                              onPressed: () {
                                sesCal();
                                titresimCal();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HakkimdaPage()));
                              },
                              icon: Icon(
                                Icons.warning,
                                size: (screenHeight / 100) * 3,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                /*
                SizedBox(
                  height: bottomSizeBoxHeight,
                ),*/
              ],
            ),
          ),
          // ! -----------------------------------------------------------------------
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            top: (screenHeight / 100) * 7.2,
            right: _isMenuOpen ? 0 : (-screenWidth * 1.2),
            child: Container(
              width: screenWidth * 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: (screenWidth / 100) * 2),
                  Container(
                    alignment: Alignment.center,
                    height: (screenWidth / 100) * 12,
                    width: (screenWidth / 100) * 12,
                    decoration: BoxDecoration(
                        color: colorPrimary1,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      onPressed: () {
                        sesCal();
                        titresimCal();
                        changeColor(colorPrimary1, colorSecondary1);
                      },
                      icon: Icon(
                        Icons.square_outlined,
                        size: (screenWidth / 100) * 6,
                      ),
                      color: colorSecondary1,
                    ),
                  ),
                  SizedBox(width: (screenWidth / 100) * 2),
                  Container(
                    alignment: Alignment.center,
                    height: (screenWidth / 100) * 12,
                    width: (screenWidth / 100) * 12,
                    decoration: BoxDecoration(
                        color: colorPrimary2,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      onPressed: () {
                        sesCal();
                        titresimCal();
                        changeColor(colorPrimary2, colorSecondary2);
                      },
                      icon: Icon(
                        Icons.square_outlined,
                        size: (screenWidth / 100) * 6,
                      ),
                      color: colorSecondary2,
                    ),
                  ),
                  SizedBox(width: (screenWidth / 100) * 2),
                  Container(
                    height: (screenWidth / 100) * 12,
                    width: (screenWidth / 100) * 12,
                    decoration: BoxDecoration(
                        color: colorPrimary3,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      onPressed: () {
                        sesCal();
                        titresimCal();
                        changeColor(colorPrimary3, colorSecondary3);
                      },
                      icon: Icon(
                        Icons.square_outlined,
                        size: (screenWidth / 100) * 6,
                      ),
                      color: colorSecondary3,
                    ),
                  ),
                  SizedBox(width: (screenWidth / 100) * 2),
                  Container(
                    height: (screenWidth / 100) * 12,
                    width: (screenWidth / 100) * 12,
                    decoration: BoxDecoration(
                        color: colorPrimary4,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      onPressed: () {
                        sesCal();
                        titresimCal();
                        changeColor(colorPrimary4, colorSecondary4);
                      },
                      icon: Icon(
                        Icons.square_outlined,
                        size: (screenWidth / 100) * 6,
                      ),
                      color: colorSecondary4,
                    ),
                  ),
                  SizedBox(width: (screenWidth / 100) * 2),
                  Container(
                    alignment: Alignment.center,
                    height: (screenWidth / 100) * 12,
                    width: (screenWidth / 100) * 12,
                    decoration: BoxDecoration(
                        color: colorPrimary5,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      onPressed: () {
                        sesCal();
                        titresimCal();
                        changeColor(colorPrimary5, colorSecondary5);
                      },
                      icon: Icon(
                        Icons.square_outlined,
                        size: (screenWidth / 100) * 6,
                      ),
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
