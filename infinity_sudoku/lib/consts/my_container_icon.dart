import 'package:flutter/material.dart';

class MyContainerIcon extends StatelessWidget {
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
      child: Icon(Icons.clear),
    );
  }
}
