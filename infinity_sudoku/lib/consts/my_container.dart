import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String text; // Dinamik metin için bir değişken tanımlayın
  final Color renk1;
  final Color renk2;
  final double yukseklik;

  // Constructor oluşturun ve text değişkenini alın
  const MyContainer(
      {Key? key,
      required this.text,
      required this.renk1,
      required this.renk2,
      required this.yukseklik})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: yukseklik * 2,
      width: yukseklik * 2,
      decoration: BoxDecoration(
          color: renk1,
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: Color.fromARGB(9, 19, 19, 19), width: 5)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: yukseklik, color: renk2, fontWeight: FontWeight.w900),
      ),
    );
  }
}
