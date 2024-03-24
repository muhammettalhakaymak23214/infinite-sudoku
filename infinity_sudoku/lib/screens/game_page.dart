import 'dart:math';

import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final String oyunModuTercihi;

  GamePage({required this.oyunModuTercihi});
  // const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<int> sayiHavuzu = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<List<int>> hucreler = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  List<List<int>> satirlar = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  List<List<int>> sutunlar = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
  List<int> tempSayiHavuzu = [];
  List<int> tempHucreSayiHazvuzu = [];
  List<int> tempSatirSayiHavuzu = [];
  List<int> tempSutunSayiHavuzu = [];
  int sayacSatir = 0;
  Random random = Random();
  int rastgeleSayi = 0;
  int eklenecekSayi = 0;
  int devammi = 0;

  @override
  void initState() {
    creatSudoku();
    debugPrint("bitii-------------------------------++++++++++++++++++++");
    super.initState();
  }

  void creatSudoku() {
    while (sayacSatir < 9) {
      int sayac2 = 0;
      while (sayac2 < 9) {
        int sayic1 = 0;
        while (sayic1 < satirlar.length) {
          debugPrint("Satirlar : " + satirlar[sayic1].toString());
          sayic1++;
        }
        int sayic2 = 0;
        while (sayic2 < sutunlar.length) {
          debugPrint("sutunlar : " + sutunlar[sayic2].toString());
          sayic2++;
        }
        int sayic3 = 0;
        while (sayic3 < hucreler.length) {
          debugPrint("hucreler : " + hucreler[sayic3].toString());
          sayic3++;
        }

        devammi = 0;
        tempSayiHavuzu = sayiHavuzu;
        //
        if (sayacSatir < 3 && sayac2 < 3) {
          tempHucreSayiHazvuzu = hucreler[0];
        }
        //
        else if (sayacSatir < 3 && sayac2 > 2 && sayac2 < 6) {
          tempHucreSayiHazvuzu = hucreler[1];
        }
        //
        else if (sayacSatir < 3 && sayac2 > 5 && sayac2 < 9) {
          tempHucreSayiHazvuzu = hucreler[2];
        }
        //
        else if (sayacSatir > 2 && sayacSatir < 6 && sayac2 < 3) {
          tempHucreSayiHazvuzu = hucreler[3];
        } else if (sayacSatir > 2 &&
            sayacSatir < 6 &&
            sayac2 > 2 &&
            sayac2 < 6) {
          tempHucreSayiHazvuzu = hucreler[4];
        } else if (sayacSatir > 2 &&
            sayacSatir < 6 &&
            sayac2 > 5 &&
            sayac2 < 9) {
          tempHucreSayiHazvuzu = hucreler[5];
        }
        //
        else if (sayacSatir > 5 && sayac2 < 3) {
          tempHucreSayiHazvuzu = hucreler[6];
        } else if (sayacSatir > 5 && sayac2 > 2 && sayac2 < 6) {
          tempHucreSayiHazvuzu = hucreler[7];
        } else if (sayacSatir > 5 && sayac2 > 5 && sayac2 < 9) {
          tempHucreSayiHazvuzu = hucreler[8];
        } else {
          debugPrint("hatahatahatahatahatahatahatahatahataatahata");
        }
        //
        tempSatirSayiHavuzu = satirlar[sayacSatir];
        tempSutunSayiHavuzu = sutunlar[sayac2];
        // debugPrint("SAYİ Havuzu:" + tempSayiHavuzu.toString());
        //debugPrint("SATİR SAYİ Havuzu:" + tempSatirSayiHavuzu.toString());
        //debugPrint("SUTUN SAYİ Havuzu:" + tempSutunSayiHavuzu.toString());
        //debugPrint("HUCRE SAYİ Havuzu:" + tempHucreSayiHazvuzu.toString());

        //
        tempSayiHavuzu = tempSayiHavuzu
            .toSet()
            .difference(tempHucreSayiHazvuzu.toSet())
            .toList();
        tempSayiHavuzu = tempSayiHavuzu
            .toSet()
            .difference(tempSatirSayiHavuzu.toSet())
            .toList();
        tempSayiHavuzu = tempSayiHavuzu
            .toSet()
            .difference(tempSutunSayiHavuzu.toSet())
            .toList();
        //debugPrint("Yeni SAYİ Havuzu:" + tempSayiHavuzu.toString());
        rastgeleSayi = random.nextInt(9) + 1;
        if (tempSayiHavuzu.isNotEmpty) {
          eklenecekSayi = tempSayiHavuzu[rastgeleSayi % tempSayiHavuzu.length];
          satirlar[sayacSatir].add(eklenecekSayi);
          sutunlar[sayac2].add(eklenecekSayi);
          //
          if (sayacSatir < 3 && sayac2 < 3) {
            hucreler[0].add(eklenecekSayi);
          }
          //
          else if (sayacSatir < 3 && sayac2 > 2 && sayac2 < 6) {
            hucreler[1].add(eklenecekSayi);
          }
          //
          else if (sayacSatir < 3 && sayac2 > 5 && sayac2 < 9) {
            hucreler[2].add(eklenecekSayi);
          }
          //
          else if (sayacSatir > 2 && sayacSatir < 6 && sayac2 < 3) {
            hucreler[3].add(eklenecekSayi);
          } else if (sayacSatir > 2 &&
              sayacSatir < 6 &&
              sayac2 > 2 &&
              sayac2 < 6) {
            hucreler[4].add(eklenecekSayi);
          } else if (sayacSatir > 2 &&
              sayacSatir < 6 &&
              sayac2 > 5 &&
              sayac2 < 9) {
            hucreler[5].add(eklenecekSayi);
          }
          //
          else if (sayacSatir > 5 && sayac2 < 3) {
            hucreler[6].add(eklenecekSayi);
          } else if (sayacSatir > 5 && sayac2 > 2 && sayac2 < 6) {
            hucreler[7].add(eklenecekSayi);
          } else if (sayacSatir > 5 && sayac2 > 5 && sayac2 < 9) {
            hucreler[8].add(eklenecekSayi);
          } else {
            debugPrint("hatahatahatahatahatahatahatahatahataatahata");
          }
/*
          debugPrint("SATİR :" + satirlar[sayacSatir].toString());
          debugPrint("SÜTUN :" + sutunlar[sayac2].toString());
          debugPrint("HÜCRE :" + hucreler[sayacSatir].toString());*/
          sayac2++;

          // Diğer işlemler...
        } else {
          debugPrint(
              "---------------------------------liste bos------------------------------");

          int index = sayac2 - 1;
          while (index >= 0) {
            sutunlar[index].removeLast();
            index--;
          }

          if (sayac2 == 8) {
            if (sayacSatir < 3) {
              hucreler[0].removeLast();
              hucreler[0].removeLast();
              hucreler[0].removeLast();
              hucreler[1].removeLast();
              hucreler[1].removeLast();
              hucreler[1].removeLast();
              hucreler[2].removeLast();
              hucreler[2].removeLast();
            } else if (sayacSatir > 2 && sayacSatir < 6) {
              hucreler[3].removeLast();
              hucreler[3].removeLast();
              hucreler[3].removeLast();
              hucreler[4].removeLast();
              hucreler[4].removeLast();
              hucreler[4].removeLast();
              hucreler[5].removeLast();
              hucreler[5].removeLast();
            } else if (sayacSatir > 5) {
              hucreler[6].removeLast();
              hucreler[6].removeLast();
              hucreler[6].removeLast();
              hucreler[7].removeLast();
              hucreler[7].removeLast();
              hucreler[7].removeLast();
              hucreler[8].removeLast();
              hucreler[8].removeLast();
            }
          } else if (sayac2 == 7) {
            if (sayacSatir < 3) {
              hucreler[0].removeLast();
              hucreler[0].removeLast();
              hucreler[0].removeLast();
              hucreler[1].removeLast();
              hucreler[1].removeLast();
              hucreler[1].removeLast();
              hucreler[2].removeLast();
            } else if (sayacSatir > 2 && sayacSatir < 6) {
              hucreler[3].removeLast();
              hucreler[3].removeLast();
              hucreler[3].removeLast();
              hucreler[4].removeLast();
              hucreler[4].removeLast();
              hucreler[4].removeLast();
              hucreler[5].removeLast();
            } else if (sayacSatir > 5) {
              hucreler[6].removeLast();
              hucreler[6].removeLast();
              hucreler[6].removeLast();
              hucreler[7].removeLast();
              hucreler[7].removeLast();
              hucreler[7].removeLast();
              hucreler[8].removeLast();
            }
          } else if (sayac2 == 6) {
            if (sayacSatir < 3) {
              hucreler[0].removeLast();
              hucreler[0].removeLast();
              hucreler[0].removeLast();
              hucreler[1].removeLast();
              hucreler[1].removeLast();
              hucreler[1].removeLast();
            } else if (sayacSatir > 2 && sayacSatir < 6) {
              hucreler[3].removeLast();
              hucreler[3].removeLast();
              hucreler[3].removeLast();
              hucreler[4].removeLast();
              hucreler[4].removeLast();
              hucreler[4].removeLast();
            } else if (sayacSatir > 5) {
              hucreler[6].removeLast();
              hucreler[6].removeLast();
              hucreler[6].removeLast();
              hucreler[7].removeLast();
              hucreler[7].removeLast();
              hucreler[7].removeLast();
            }
          }
          satirlar[sayacSatir].length = 0;

          // tempSayiHavuzu boşsa yapılacak işlemler veya hata işlemleri...
          tempSatirSayiHavuzu.length = 0;
          tempSayiHavuzu.length = 0;
          tempSutunSayiHavuzu.length = 0;
          tempHucreSayiHazvuzu.length = 0;
          sayac2 = 0;
          devammi = 1;
        }
      }
      //debugPrint("Satir : " + satirlar.toString());
      /*
      int sayic = 0;
      while (sayic < satirlar.length) {
        debugPrint("sayic : " + satirlar[sayic].toString());
        sayic++;
      }
      */

      sayacSatir++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.oyunModuTercihi),
      ),
    );
  }
}
