import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GamePage extends StatefulWidget {
  final String oyunModuTercihi;

  GamePage({required this.oyunModuTercihi});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int kordinatRow = 404;
  int kordinatCol = 404;
  int kordinatColRenk = 404;
  int kordinatRowRenk = 404;
  List<int> row_1 = [];
  List<int> row_2 = [];
  List<int> row_3 = [];
  List<int> row_4 = [];
  List<int> row_5 = [];
  List<int> row_6 = [];
  List<int> row_7 = [];
  List<int> row_8 = [];
  List<int> row_9 = [];

  List<int> cevap_row_1 = [];
  List<int> cevap_row_2 = [];
  List<int> cevap_row_3 = [];
  List<int> cevap_row_4 = [];
  List<int> cevap_row_5 = [];
  List<int> cevap_row_6 = [];
  List<int> cevap_row_7 = [];
  List<int> cevap_row_8 = [];
  List<int> cevap_row_9 = [];

  List<List<int>> soruSudoku = [
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
  ];
  List<List<int>> cevapSudoku = [
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
  ];

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
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 81,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

                  return GestureDetector(
                    onTap: () {
                      print('Tıklanan hücre: $value  --- hucre: $row . $col');
                      kordinatCol = col;
                      kordinatRow = row;
                      kordinatRowRenk = row;
                      kordinatColRenk = col;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          '$value',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              9,
              (index) => ElevatedButton(
                onPressed: () {
                  // Butona tıklama işlemleri buraya yazılabilir
                  sudokuCoz(index + 1);
                  setState(() {});
                },
                child: Text('${index + 1}'),
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
