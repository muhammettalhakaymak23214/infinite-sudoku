import 'package:flutter/material.dart';

class MyContainerIcon extends StatelessWidget {
  final IconData simge;
  final Color renk1;

  const MyContainerIcon({Key? key, required this.simge, required this.renk1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: renk1,
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: Color.fromARGB(9, 19, 19, 19), width: 5)),
      child: Icon(
        simge,
        size: 40,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
