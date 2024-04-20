import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HakkimdaPage extends StatefulWidget {
  const HakkimdaPage({super.key});

  @override
  State<HakkimdaPage> createState() => _HakkimdaPageState();
}

class _HakkimdaPageState extends State<HakkimdaPage> {
  Uri googleUrl =
      Uri.parse('https://pub.dev/packages/flutter_inappwebview/install');

  Future<void> _launch(Uri url) async {
    await canLaunchUrl(url);
  }

  _launchURL(String url) async {
    final Uri url1 = Uri.parse(url);
    if (!await launchUrl(url1)) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: (screenHeight / 100) * 25,
              width: (screenWidth / 100) * 90,
              decoration: BoxDecoration(
                color: Color.fromARGB(242, 0, 6, 16),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 1, // Kenar kalınlığını ayarlayın
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent
                        .withOpacity(0.5), // Neon rengini ayarlayın
                    spreadRadius: 3, // Yayılma yarıçapını ayarlayın
                    blurRadius: 7, // Bulanıklık yarıçapını ayarlayın
                    offset: Offset(0, 0), // Gölge konumunu ayarlayın
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: (screenHeight / 100) * 5,
                    width: (screenWidth / 100) * 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(242, 0, 6, 16),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.blueAccent,
                        width: 1, // Kenar kalınlığını ayarlayın
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent
                              .withOpacity(0.5), // Neon rengini ayarlayın
                          spreadRadius: 3, // Yayılma yarıçapını ayarlayın
                          blurRadius: 7, // Bulanıklık yarıçapını ayarlayın
                          offset: Offset(0, 0), // Gölge konumunu ayarlayın
                        ),
                      ],
                    ),
                    child: Text(
                      "Muhammet Talha Kaymak",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenHeight / 100) * 2),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight / 100) * 5,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://www.linkedin.com/in/muhammet-talha-kaymak-932447195/");
                            // Butona tıklandığında yapılacak işlemler
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: (screenHeight / 100) * 7,
                            width: (screenHeight / 100) * 7,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(242, 0, 6, 16),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 1, // Kenar kalınlığını ayarlayın
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(
                                      0.5), // Neon rengini ayarlayın
                                  spreadRadius:
                                      3, // Yayılma yarıçapını ayarlayın
                                  blurRadius:
                                      7, // Bulanıklık yarıçapını ayarlayın
                                  offset:
                                      Offset(0, 0), // Gölge konumunu ayarlayın
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.linkedin,
                              size: 30,
                              color: Colors.white, // İkon rengi
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://github.com/muhammettalhakaymak23214");
                            // Butona tıklandığında yapılacak işlemler
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: (screenHeight / 100) * 7,
                            width: (screenHeight / 100) * 7,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(242, 0, 6, 16),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 1, // Kenar kalınlığını ayarlayın
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(
                                      0.5), // Neon rengini ayarlayın
                                  spreadRadius:
                                      3, // Yayılma yarıçapını ayarlayın
                                  blurRadius:
                                      7, // Bulanıklık yarıçapını ayarlayın
                                  offset:
                                      Offset(0, 0), // Gölge konumunu ayarlayın
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.github,
                              size: 30,
                              color: Colors.white, // İkon rengi
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://www.instagram.com/muhammet__kaymak/");
                            // Butona tıklandığında yapılacak işlemler
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: (screenHeight / 100) * 7,
                            width: (screenHeight / 100) * 7,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(242, 0, 6, 16),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 1, // Kenar kalınlığını ayarlayın
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(
                                      0.5), // Neon rengini ayarlayın
                                  spreadRadius:
                                      3, // Yayılma yarıçapını ayarlayın
                                  blurRadius:
                                      7, // Bulanıklık yarıçapını ayarlayın
                                  offset:
                                      Offset(0, 0), // Gölge konumunu ayarlayın
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.instagram,
                              size: 30,
                              color: Colors.white, // İkon rengi
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            SizedBox(
              height: (screenHeight / 100) * 5,
            ),
            Container(
              height: (screenHeight / 100) * 25,
              width: (screenWidth / 100) * 90,
              decoration: BoxDecoration(
                color: Color.fromARGB(242, 0, 6, 16),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 1, // Kenar kalınlığını ayarlayın
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent
                        .withOpacity(0.5), // Neon rengini ayarlayın
                    spreadRadius: 3, // Yayılma yarıçapını ayarlayın
                    blurRadius: 7, // Bulanıklık yarıçapını ayarlayın
                    offset: Offset(0, 0), // Gölge konumunu ayarlayın
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: (screenHeight / 100) * 5,
                    width: (screenWidth / 100) * 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(242, 0, 6, 16),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.blueAccent,
                        width: 1, // Kenar kalınlığını ayarlayın
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent
                              .withOpacity(0.5), // Neon rengini ayarlayın
                          spreadRadius: 3, // Yayılma yarıçapını ayarlayın
                          blurRadius: 7, // Bulanıklık yarıçapını ayarlayın
                          offset: Offset(0, 0), // Gölge konumunu ayarlayın
                        ),
                      ],
                    ),
                    child: Text(
                      "Serhat Çelik",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenHeight / 100) * 2),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight / 100) * 5,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://www.linkedin.com/in/serhat-%C3%A7elik-845678223/");
                            // Butona tıklandığında yapılacak işlemler
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: (screenHeight / 100) * 7,
                            width: (screenHeight / 100) * 7,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(242, 0, 6, 16),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 1, // Kenar kalınlığını ayarlayın
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(
                                      0.5), // Neon rengini ayarlayın
                                  spreadRadius:
                                      3, // Yayılma yarıçapını ayarlayın
                                  blurRadius:
                                      7, // Bulanıklık yarıçapını ayarlayın
                                  offset:
                                      Offset(0, 0), // Gölge konumunu ayarlayın
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.linkedin,
                              size: 30,
                              color: Colors.white, // İkon rengi
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL("https://github.com/theserce");
                            // Butona tıklandığında yapılacak işlemler
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: (screenHeight / 100) * 7,
                            width: (screenHeight / 100) * 7,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(242, 0, 6, 16),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 1, // Kenar kalınlığını ayarlayın
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(
                                      0.5), // Neon rengini ayarlayın
                                  spreadRadius:
                                      3, // Yayılma yarıçapını ayarlayın
                                  blurRadius:
                                      7, // Bulanıklık yarıçapını ayarlayın
                                  offset:
                                      Offset(0, 0), // Gölge konumunu ayarlayın
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.github,
                              size: 30,
                              color: Colors.white, // İkon rengi
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "https://www.instagram.com/serce_official/");
                            // Butona tıklandığında yapılacak işlemler
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: (screenHeight / 100) * 7,
                            width: (screenHeight / 100) * 7,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(242, 0, 6, 16),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 1, // Kenar kalınlığını ayarlayın
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(
                                      0.5), // Neon rengini ayarlayın
                                  spreadRadius:
                                      3, // Yayılma yarıçapını ayarlayın
                                  blurRadius:
                                      7, // Bulanıklık yarıçapını ayarlayın
                                  offset:
                                      Offset(0, 0), // Gölge konumunu ayarlayın
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.instagram,
                              size: 30,
                              color: Colors.white, // İkon rengi
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            SizedBox(
              height: (screenHeight / 100) * 5,
            ),
            Container(
              height: (screenHeight / 100) * 25,
              width: (screenWidth / 100) * 90,
              decoration: BoxDecoration(
                color: Color.fromARGB(242, 0, 6, 16),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 1, // Kenar kalınlığını ayarlayın
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent
                        .withOpacity(0.5), // Neon rengini ayarlayın
                    spreadRadius: 3, // Yayılma yarıçapını ayarlayın
                    blurRadius: 7, // Bulanıklık yarıçapını ayarlayın
                    offset: Offset(0, 0), // Gölge konumunu ayarlayın
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: (screenHeight / 100) * 5,
                    width: (screenWidth / 100) * 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(242, 0, 6, 16),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.blueAccent,
                        width: 1, // Kenar kalınlığını ayarlayın
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent
                              .withOpacity(0.5), // Neon rengini ayarlayın
                          spreadRadius: 3, // Yayılma yarıçapını ayarlayın
                          blurRadius: 7, // Bulanıklık yarıçapını ayarlayın
                          offset: Offset(0, 0), // Gölge konumunu ayarlayın
                        ),
                      ],
                    ),
                    child: Text(
                      "Uygulamanın Kaynak Kodu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenHeight / 100) * 2),
                    ),
                  ),
                  SizedBox(
                    height: (screenHeight / 100) * 5,
                  ),
                  InkWell(
                    onTap: () {
                      _launchURL(
                          "https://github.com/muhammettalhakaymak23214/infinite-sudoku");
                      // Butona tıklandığında yapılacak işlemler
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: (screenHeight / 100) * 7,
                      width: (screenHeight / 100) * 7,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(242, 0, 6, 16),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 1, // Kenar kalınlığını ayarlayın
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent
                                .withOpacity(0.5), // Neon rengini ayarlayın
                            spreadRadius: 3, // Yayılma yarıçapını ayarlayın
                            blurRadius: 7, // Bulanıklık yarıçapını ayarlayın
                            offset: Offset(0, 0), // Gölge konumunu ayarlayın
                          ),
                        ],
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.code,
                        size: 30,
                        color: Colors.white, // İkon rengi
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
