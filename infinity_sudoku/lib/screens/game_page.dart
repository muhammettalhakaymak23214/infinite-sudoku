import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infinity_sudoku/consts/listeler.dart';
import 'package:infinity_sudoku/consts/my_container.dart';
import 'package:infinity_sudoku/consts/my_container_icon.dart';
import 'package:infinity_sudoku/screens/menu_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class GamePage extends StatefulWidget {
  final String oyunModuTercihi;
  final Color birincilRenk;
  final Color ikincilRenk;

  GamePage(
      {required this.oyunModuTercihi,
      required this.birincilRenk,
      required this.ikincilRenk});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  int cozulenSudokuSuresi = 0;
  int cozulenSudokuSayisi = 0;
  int secilenValue = 404;
  int kordinatAyarRow = 404;
  int kordinatAyarCol = 404;
  int kordinatRow = 404;
  int kordinatCol = 404;
  int kordinatColRenk = 404;
  int kordinatRowRenk = 404;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool sesDurumu = false;
  bool titresimDurumu = false;

  @override
  void initState() {
    super.initState();
    _getirSecilenSes();
    _getirSecilenTitresim();
    fetchData();
    _startTimer();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: -30.0,
      end: 30.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
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

  Future<void> _getirSecilenSes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sesDurumu = prefs.getBool('sesDurumu') ?? false;
  }

  Future<void> _getirSecilenTitresim() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    titresimDurumu = prefs.getBool('titresimDurumu') ?? false;
  }

  void zorlukAyariYap() {
    if (widget.oyunModuTercihi == "Kolay") {
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
    } else if (widget.oyunModuTercihi == "Orta") {
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
      ipucuGetir();
    } else {
      debugPrint("zorluk zormuş--------------------------------");
    }
  }

  void reset() {
    fetchData();
    _timer.cancel();
    _seconds = 0;
    _minutes = 0;
    _startTimer();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: -30.0,
      end: 30.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
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

  Future<void> _saveSudokuSayisi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cozulenSudokuSayisi = prefs.getInt('cozulenSudokuSayisi') ?? 0;
    setState(() {
      cozulenSudokuSayisi++;
    });
    await prefs.setInt('cozulenSudokuSayisi', cozulenSudokuSayisi);
  }

  Future<void> _saveSudokuSuresi(int timeSudoku) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cozulenSudokuSuresi = prefs.getInt('cozulenSudokuSuresi') ?? 0;
    setState(() {
      cozulenSudokuSuresi = cozulenSudokuSuresi + timeSudoku;
    });
    await prefs.setInt('cozulenSudokuSuresi', cozulenSudokuSuresi);
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
    zorlukAyariYap();
  }

  void sayilaraBasildi(int sayi) {
    sesCal();
    titresimCal();
    sudokuCoz(sayi);
    ayarSudokuDuzenle("Y");
    //setState(() {});
    hesapla();
  }

  void ipucuGetir() {
    int sayac = 0;
    while (sayac < 9) {
      int sayac2 = 0;
      while (sayac2 < 9) {
        if (ayarSudoku[sayac][sayac2] == "B") {
          //cevapSudoku[sayac][sayac2] =
          ipucuListesi.add([sayac, sayac2]);
        }
        sayac2++;
      }
      sayac++;
    }
    debugPrint(ipucuListesi.toString());
    var random = Random();
    int randomNumber = random
        .nextInt(101); // 0 ile 100 arasında rastgele bir tamsayı elde eder
    var rastgeleindex = (randomNumber % ipucuListesi.length);
    if (rastgeleindex != 0) {
      rastgeleindex--;
    }
    print("$rastgeleindex :=> ${ipucuListesi[rastgeleindex].toString()}");
    soruSudoku[ipucuListesi[rastgeleindex][0]][ipucuListesi[rastgeleindex][1]] =
        cevapSudoku[ipucuListesi[rastgeleindex][0]]
            [ipucuListesi[rastgeleindex][1]];
    ayarSudoku[ipucuListesi[rastgeleindex][0]][ipucuListesi[rastgeleindex][1]] =
        "i";
    ipucuListesi.clear();
    hesapla();
  }

  void hesapla() {
    int omeygat = 0;
    int sayac = 0;
    while (sayac < 9) {
      int sayac2 = 0;
      while (sayac2 < 9) {
        if (soruSudoku[sayac][sayac2] == cevapSudoku[sayac][sayac2]) {
        } else {
          omeygat = 1;
        }
        sayac2++;
      }
      sayac++;
    }
    if (omeygat == 0) {
      debugPrint("basariliiiiiiiiiiiiiiiiiiiiiiiiiiiii");
      _stopTimer();
      _saveSudokuSayisi();
      int timeSudoku = 0;
      timeSudoku = (_minutes * 60) + _seconds;

      _saveSudokuSuresi(timeSudoku);
      _dogruSonuc(context);
    } else {
      debugPrint("fdsdddddddddddddddddddddddddddddddd");
    }
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

  bool _isTimerRunning = false;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds < 59) {
          _seconds++;
        } else {
          _seconds = 0;
          _minutes++;
        }
      });
    });
    _isTimerRunning = true;
  }

  int _minutes = 0;
  int _seconds = 0;
  late Timer _timer;
  @override
  void dispose() {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _stopTimer() {
    _timer.cancel();
    _isTimerRunning = false;
  }

  @override
  Future<void> _showAlertDialog(BuildContext context) async {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.97),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: widget.ikincilRenk, width: 2.0),
            ),
            backgroundColor: widget.birincilRenk,
            title: Text(
              'Oyun Durdu',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: (screenHeight / 100) * 2),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.timer_off,
                    size: (screenHeight / 100) * 3,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Başlatmak için devam edebilirsiniz.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: (screenHeight / 100) * 2),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_animation.value, 0.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          sesCal();
                          titresimCal();
                          _startTimer();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: widget.ikincilRenk,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white, width: 2.5),
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            size: (screenHeight / 100) * 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Future<void> _dogruSonuc(BuildContext context) async {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.97),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: widget.ikincilRenk, width: 2.0),
            ),
            backgroundColor: widget.birincilRenk,
            title: Text(
              'Tebrikler Sudokuyu Çözdün',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: (screenHeight / 100) * 2),
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.child_care,
                    size: (screenHeight / 100) * 2,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$_minutes:${_seconds < 10 ? '0$_seconds' : _seconds}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: (screenHeight / 100) * 2),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    sesCal();
                    titresimCal();
                    _startTimer();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MenuPage()));
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: widget.ikincilRenk,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      size: (screenHeight / 100) * 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(0, 242, 3, 3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
              flex: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      sesCal();
                      titresimCal();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MenuPage()));
                    },
                    child: Container(
                        // height: 50,
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        margin: const EdgeInsetsDirectional.only(top: 50),
                        decoration: BoxDecoration(
                            color: widget.ikincilRenk,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 2.5)),
                        child: Icon(
                          Icons.arrow_back,
                          size: (screenHeight / 100) * 3,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                  Container(
                    // height: 50,
                    alignment: Alignment.center,
                    width: 200,
                    margin: const EdgeInsetsDirectional.only(top: 50),

                    decoration: BoxDecoration(
                        color: widget.ikincilRenk,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 2.5)),
                    child: Text(
                      "$_minutes:${_seconds < 10 ? '0$_seconds' : _seconds}",
                      style: TextStyle(
                          fontSize: (screenHeight / 100) * 3,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sesCal();
                      titresimCal();
                      _stopTimer();
                      _showAlertDialog(context);
                    },
                    child: Container(
                        // height: 50,
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        margin: const EdgeInsetsDirectional.only(top: 50),
                        decoration: BoxDecoration(
                            color: widget.ikincilRenk,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 2.5)),
                        child: Icon(
                          Icons.pause,
                          size: (screenHeight / 100) * 3,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Expanded(
            flex: 36,
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
                  FontStyle fontTarzi = FontStyle.normal;
                  // Satır ve sütun indekslerine göre arka plan rengini belirle
                  Color backgroundColor = Colors.white;
                  Color kenarlikRengi = Colors.white;
                  if ((row ~/ 3 + col ~/ 3) % 2 == 0) {
                    backgroundColor = widget.birincilRenk;
                    if ((row == kordinatRowRenk) && (col == kordinatColRenk)) {
                      backgroundColor = Color.fromARGB(255, 0, 34, 251);
                      kenarlikRengi = Colors.white;
                    }
                  } else {
                    backgroundColor = widget.ikincilRenk;
                    if ((row == kordinatRowRenk) && (col == kordinatColRenk)) {
                      backgroundColor = Color.fromARGB(255, 0, 34, 251);
                      kenarlikRengi = Colors.white;
                    }
                  }
                  if (secilenValue == value && value != 0) {
                    //backgroundColor = Color.fromARGB(255, 71, 251, 0);
                    kenarlikRengi = Color.fromARGB(255, 255, 0, 0);
                  }

                  Color textColor = Color.fromARGB(255, 217, 255, 0);
                  if (ayarSudoku[row][col] == "B") {
                    fontTarzi = FontStyle.normal;
                    textColor = const Color.fromARGB(0, 255, 255, 255);
                  } else if (ayarSudoku[row][col] == "X") {
                    fontTarzi = FontStyle.italic;
                    textColor = Color.fromARGB(255, 217, 255, 0);
                  } else if (ayarSudoku[row][col] == "Y") {
                    fontTarzi = FontStyle.normal;
                    textColor = Color.fromARGB(255, 255, 255, 255);
                  } else if (ayarSudoku[row][col] == "i") {
                    textColor = Color.fromARGB(255, 217, 255, 0);
                    fontTarzi = FontStyle.italic;
                  }

                  return GestureDetector(
                    onTap: () {
                      sesCal();
                      titresimCal();
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
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          color: backgroundColor,
                          border: Border.all(color: kenarlikRengi, width: 2.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          '$value',
                          style: TextStyle(
                            fontSize: (screenHeight / 100) * 3,
                            color: textColor,
                            fontWeight: FontWeight.w900,
                            fontStyle: fontTarzi,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          // ! Tuş Takımı Başı ----------------------------------------------------------------------------
          Expanded(
            flex: 22,
            child: Container(
              margin: EdgeInsets.only(top: 0, left: 10, right: 10),
              decoration: BoxDecoration(
                  color: widget.ikincilRenk,
                  border: Border.all(color: Colors.white, width: 2.5),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () => sayilaraBasildi(1),
                          child: MyContainer(
                            text: "1",
                            renk1: widget.birincilRenk,
                            renk2: const Color.fromARGB(255, 255, 255, 255),
                            yukseklik: (screenHeight / 100) * 3,
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(4),
                          child: MyContainer(
                            text: "4",
                            renk1: widget.birincilRenk,
                            renk2: const Color.fromARGB(255, 255, 255, 255),
                            yukseklik: (screenHeight / 100) * 3,
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(7),
                          child: MyContainer(
                            text: "7",
                            renk1: widget.birincilRenk,
                            renk2: const Color.fromARGB(255, 255, 255, 255),
                            yukseklik: (screenHeight / 100) * 3,
                          )),
                      GestureDetector(
                        onTap: () {
                          sesCal();
                          titresimCal();
                          sudokuCoz(0);
                          ayarSudokuDuzenle("B");
                          setState(() {});
                        },
                        child: MyContainerIcon(
                          simge: Icons.clear,
                          renk1: widget.birincilRenk,
                          yukseklik: (screenHeight / 100) * 3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () => sayilaraBasildi(2),
                          child: MyContainer(
                            text: "2",
                            renk1: widget.birincilRenk,
                            renk2: const Color.fromARGB(255, 255, 255, 255),
                            yukseklik: (screenHeight / 100) * 3,
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(5),
                          child: MyContainer(
                            text: "5",
                            renk1: widget.birincilRenk,
                            renk2: const Color.fromARGB(255, 255, 255, 255),
                            yukseklik: (screenHeight / 100) * 3,
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(8),
                          child: MyContainer(
                            text: "8",
                            renk1: widget.birincilRenk,
                            renk2: const Color.fromARGB(255, 255, 255, 255),
                            yukseklik: (screenHeight / 100) * 3,
                          )),
                      GestureDetector(
                        onTap: () {
                          sesCal();
                          titresimCal();
                          ipucuGetir();
                          setState(() {});
                        },
                        child: MyContainerIcon(
                          simge: Icons.lightbulb_rounded,
                          renk1: widget.birincilRenk,
                          yukseklik: (screenHeight / 100) * 3,
                        ),
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
                          onTap: () => sayilaraBasildi(3),
                          child: MyContainer(
                            text: "3",
                            renk1: widget.birincilRenk,
                            renk2: const Color.fromARGB(255, 255, 255, 255),
                            yukseklik: (screenHeight / 100) * 3,
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(6),
                          child: MyContainer(
                            text: "6",
                            renk1: widget.birincilRenk,
                            renk2: const Color.fromARGB(255, 255, 255, 255),
                            yukseklik: (screenHeight / 100) * 3,
                          )),
                      GestureDetector(
                          onTap: () => sayilaraBasildi(9),
                          child: MyContainer(
                            text: "9",
                            renk1: widget.birincilRenk,
                            renk2: const Color.fromARGB(255, 255, 255, 255),
                            yukseklik: (screenHeight / 100) * 3,
                          )),
                      GestureDetector(
                        onTap: () {
                          sesCal();
                          titresimCal();
                          reset();
                          setState(() {});
                        },
                        child: MyContainerIcon(
                          simge: Icons.restart_alt_rounded,
                          renk1: widget.birincilRenk,
                          yukseklik: (screenHeight / 100) * 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          // ! Tuş Takımı Sonu ----------------------------------------------------------------------------
        ],
      ),
    );
  }
}
