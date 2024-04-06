import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String text; // Dinamik metin için bir değişken tanımlayın

  // Constructor oluşturun ve text değişkenini alın
  const MyContainer({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: Color.fromARGB(9, 19, 19, 19), width: 5)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
