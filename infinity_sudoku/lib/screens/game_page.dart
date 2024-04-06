import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinity_sudoku/consts/listeler.dart';
import 'package:infinity_sudoku/consts/my_container.dart';
import 'package:infinity_sudoku/consts/my_container_icon.dart';

class GamePage extends StatefulWidget {
  final String oyunModuTercihi;

  GamePage({required this.oyunModuTercihi});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int secilenValue = 404;
  int kordinatAyarRow = 404;
  int kordinatAyarCol = 404;
  int kordinatRow = 404;
  int kordinatCol = 404;
  int kordinatColRenk = 404;
  int kordinatRowRenk = 404;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://sudoku-api.vercel.app/api/dosuku'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      row_1 = List<int>.from(jsonData['newboard']['grids'][0]['value'][0]);
      row_2 = List<int>.from(jsonData['newboard']['grids'][0]['value'][1]);
      row_3 = List<int>.from(jsonData['newboard']['grids'][0]['value'][2]);
      row_4 = List<int>.from(jsonData['newboard']['grids'][0]['value'][3]);
      row_5 = List<int>.from(jsonData['newboard']['grids'][0]['value'][4]);
      row_6 = List<int>.from(jsonData['newboard']['grids'][0]['value'][5]);
      row_7 = List<int>.from(jsonData['newboard']['grids'][0]['value'][6]);
      row_8 = List<int>.from(jsonData['newboard']['grids'][0]['value'][7]);
      row_9 = List<int>.from(jsonData['newboard']['grids'][0]['value'][8]);
      debugPrint(row_1.toString());
      debugPrint(row_2.toString());
      debugPrint(row_3.toString());
      debugPrint(row_4.toString());
      debugPrint(row_5.toString());
      debugPrint(row_6.toString());
      debugPrint(row_7.toString());
      debugPrint(row_8.toString());
      debugPrint(row_9.toString());
      //---------------------------------------------------------------------
      cevap_row_1 =
          List<int>.from(jsonData['newboard']['grids'][0]['solution'][0]);
      cevap_row_2 =
          List<int>.from(jsonData['newboard']['grids'][0]['solution'][1]);
      cevap_row_3 =
          List<int>.from(jsonData['newboard']['grids'][0]['solution'][2]);
      cevap_row_4 =
          List<int>.from(jsonData['newboard']['grids'][0]['solution'][3]);
      cevap_row_5 =
          List<int>.from(jsonData['newboard']['grids'][0]['solution'][4]);
      cevap_row_6 =
          List<int>.from(jsonData['newboard']['grids'][0]['solution'][5]);
      cevap_row_7 =
          List<int>.from(jsonData['newboard']['grids'][0]['solution'][6]);
      cevap_row_8 =
          List<int>.from(jsonData['newboard']['grids'][0]['solution'][7]);
      cevap_row_9 =
          List<int>.from(jsonData['newboard']['grids'][0]['solution'][8]);
      debugPrint(cevap_row_1.toString());
      debugPrint(cevap_row_2.toString());
      debugPrint(cevap_row_3.toString());
      debugPrint(cevap_row_4.toString());
      debugPrint(cevap_row_5.toString());
      debugPrint(cevap_row_6.toString());
      debugPrint(cevap_row_7.toString());
      debugPrint(cevap_row_8.toString());
      debugPrint(cevap_row_9.toString());
//-----------------------------
      sudokuOlustur();
    } else {
      throw Exception(
          '--------------- Apide hata meydana geldi! ------------------');
    }
  }

  void sudokuOlustur() {
    soruSudoku[0] = row_1;
    soruSudoku[1] = row_2;
    soruSudoku[2] = row_3;
    soruSudoku[3] = row_4;
    soruSudoku[4] = row_5;
    soruSudoku[5] = row_6;
    soruSudoku[6] = row_7;
    soruSudoku[7] = row_8;
    soruSudoku[8] = row_9;
//----------------------
    cevapSudoku[0] = cevap_row_1;
    cevapSudoku[1] = cevap_row_2;
    cevapSudoku[2] = cevap_row_3;
    cevapSudoku[3] = cevap_row_4;
    cevapSudoku[4] = cevap_row_5;
    cevapSudoku[5] = cevap_row_6;
    cevapSudoku[6] = cevap_row_7;
    cevapSudoku[7] = cevap_row_8;
    cevapSudoku[8] = cevap_row_9;
    ayarSudokuOlustur();
    setState(() {});
  }

  void sayilaraBasildi(int sayi) {
    sudokuCoz(sayi);
    ayarSudokuDuzenle("Y");
    setState(() {});
  }

  void ayarSudokuOlustur() {
    int sayac0 = 0;
    while (sayac0 < 9) {
      int sayac1 = 0;
      while (sayac1 < 9) {
        if (soruSudoku[sayac0][sayac1] == 0) {
          ayarSudoku[sayac0][sayac1] = "B";
        } else if (soruSudoku[sayac0][sayac1] != 0) {
          ayarSudoku[sayac0][sayac1] = "X";
        }
        sayac1++;
      }
      sayac0++;
    }
    debugPrint(ayarSudoku[0].toString());
  }

  void sudokuCoz(int newValue) {
    if (kordinatCol != 404 && kordinatRow != 404) {
      soruSudoku[kordinatRow][kordinatCol] = newValue;
      debugPrint(soruSudoku.toString());
      setState(() {});
    } else {
      debugPrint("-----------------hata----------------");
    }
  }

  void ayarSudokuDuzenle(String deger) {
    ayarSudoku[kordinatAyarRow][kordinatAyarCol] = deger;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 2,
              child: Container(
                // height: 50,
                alignment: Alignment.center,
                width: 200,
                margin: const EdgeInsetsDirectional.only(top: 50),

                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "20.15",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: GridView.builder(
                itemCount: 81,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final row = index ~/ 9;
                  final col = index % 9;
                  final value = soruSudoku[row][col];

                  // Satır ve sütun indekslerine göre arka plan rengini belirle
                  Color backgroundColor = Colors.white;
                  if ((row ~/ 3 + col ~/ 3) % 2 == 0) {
                    backgroundColor = Colors.amber;
                    if ((row == kordinatRowRenk) && (col == kordinatColRenk)) {
                      backgroundColor = Color.fromARGB(255, 0, 34, 251);
                    }
                  } else {
                    backgroundColor = Colors.white;
                    if ((row == kordinatRowRenk) && (col == kordinatColRenk)) {
                      backgroundColor = Color.fromARGB(255, 0, 34, 251);
                    }
                  }
                  if (secilenValue == value && value != 0) {
                    backgroundColor = Color.fromARGB(255, 71, 251, 0);
                  }

                  Color textColor = const Color.fromARGB(255, 255, 0, 0);
                  if (ayarSudoku[row][col] == "B") {
                    textColor = const Color.fromARGB(0, 255, 255, 255);
                  } else if (ayarSudoku[row][col] == "X") {
                    textColor = Color.fromARGB(255, 255, 0, 0);
                  } else if (ayarSudoku[row][col] == "Y") {
                    textColor = const Color.fromARGB(255, 0, 0, 0);
                  }

                  return GestureDetector(
                    onTap: () {
                      print('Tıklanan hücre: $value  --- hucre: $row . $col');
                      if (ayarSudoku[row][col] == "B" ||
                          ayarSudoku[row][col] == "Y") {
                        kordinatCol = col;
                        kordinatRow = row;
                        kordinatRowRenk = row;
                        kordinatColRenk = col;
                        kordinatAyarCol = col;
                        kordinatAyarRow = row;
                        setState(() {});
                      } else {
                        kordinatCol = 404;
                        kordinatRow = 404;

                        debugPrint("hatatattataa");
                      }
                      if (value != 0) {
                        secilenValue = value;
                      }
                      secilenValue = value;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          '$value',
                          style: TextStyle(fontSize: 20.0, color: textColor),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // ! Tuş Takımı Başı ----------------------------------------------------------------------------
          Expanded(
            flex: 5,
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              //color: Colors.amber,
              child: Column(
                children: [
                  //const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () => sayilaraBasildi(1),
                          child: const MyContainer(
                            text: "1",
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(2),
                          child: const MyContainer(
                            text: "2",
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(3),
                          child: const MyContainer(
                            text: "3",
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(4),
                          child: const MyContainer(
                            text: "4",
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(5),
                          child: const MyContainer(
                            text: "5",
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () => sayilaraBasildi(6),
                          child: const MyContainer(
                            text: "6",
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(7),
                          child: const MyContainer(
                            text: "7",
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(8),
                          child: const MyContainer(
                            text: "8",
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(9),
                          child: const MyContainer(
                            text: "9",
                          )),
                      GestureDetector(
                        onTap: () {
                          sudokuCoz(0);
                          ayarSudokuDuzenle("B");
                          setState(() {});
                        },
                        child: MyContainerIcon(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          sudokuCoz(0);
                          ayarSudokuDuzenle("B");
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(200)),
                          child: Icon(Icons.clear),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          sudokuCoz(0);
                          ayarSudokuDuzenle("B");
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(200)),
                          child: Icon(Icons.clear),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          sudokuCoz(0);
                          ayarSudokuDuzenle("B");
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(200)),
                          child: Icon(Icons.clear),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          sudokuCoz(0);
                          ayarSudokuDuzenle("B");
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(200)),
                          child: Icon(Icons.clear),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // ! Tuş Takımı Sonu ----------------------------------------------------------------------------
        ],
      ),
    );
  }
}



/*
 Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              10,
              (index) => Container(
                height: 30,
                width: 30,
                child: ElevatedButton(
                  onPressed: () {
                    // Butona tıklama işlemleri buraya yazılabilir
                    sudokuCoz(index);
                    if (index != 0) {
                      ayarSudokuDuzenle("Y");
                    } else {
                      ayarSudokuDuzenle("B");
                    }
                    setState(() {});
                  },
                  child: Text('${index}'),
                ),
              ),
            ),
          ),
const SizedBox(height: 20),


           ElevatedButton(
              onPressed: () {
                int omeygat = 0;
                int sayac = 0;
                while (sayac < 9) {
                  int sayac2 = 0;
                  while (sayac2 < 9) {
                    if (soruSudoku[sayac][sayac2] ==
                        cevapSudoku[sayac][sayac2]) {
                    } else {
                      omeygat = 1;
                    }
                    sayac2++;
                  }
                  sayac++;
                }
                if (omeygat == 0) {
                  debugPrint("basariliiiiiiiiiiiiiiiiiiiiiiiiiiiii");
                } else {
                  debugPrint("fdsdddddddddddddddddddddddddddddddd");
                }
              },
              child: Text("Hesapla")),


*/