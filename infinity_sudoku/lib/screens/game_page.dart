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
  late List<List<int>> grid;
  late List<int> numberList;
  int attempts = 5;
  int counter = 1;
  final int intDim = 35;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    grid = List.generate(9, (index) => List.filled(9, 0));
    numberList = List.generate(9, (index) => index + 1);
    fillGrid();
  }

  void fillGrid() {
    for (var i = 0; i < 81; i++) {
      int row = i ~/ 9;
      int col = i % 9;
      if (grid[row][col] == 0) {
        numberList.shuffle();
        for (var value in numberList) {
          if (!_isValueInRow(row, value) &&
              !_isValueInColumn(col, value) &&
              !_isValueInSquare(row - row % 3, col - col % 3, value)) {
            setState(() {
              grid[row][col] = value;
            });
            if (_checkGrid()) {
              return;
            } else {
              fillGrid();
            }
          }
        }
      }
    }
  }

  bool _isValueInRow(int row, int value) {
    return grid[row].contains(value);
  }

  bool _isValueInColumn(int col, int value) {
    for (int i = 0; i < 9; i++) {
      if (grid[i][col] == value) {
        return true;
      }
    }
    return false;
  }

  bool _isValueInSquare(int startRow, int startCol, int value) {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (grid[row + startRow][col + startCol] == value) {
          return true;
        }
      }
    }
    return false;
  }

  bool _checkGrid() {
    for (var row in grid) {
      if (row.contains(0)) {
        return false;
      }
    }
    return true;
  }

  Future<void> _solveGrid() async {
    for (var i = 0; i < 81; i++) {
      int row = i ~/ 9;
      int col = i % 9;
      if (grid[row][col] == 0) {
        for (var value = 1; value <= 9; value++) {
          if (!_isValueInRow(row, value) &&
              !_isValueInColumn(col, value) &&
              !_isValueInSquare(row - row % 3, col - col % 3, value)) {
            setState(() {
              grid[row][col] = value;
            });
            await Future.delayed(Duration(milliseconds: 100));
            if (_checkGrid()) {
              return;
            } else {
              await _solveGrid();
            }
          }
        }
        break;
      }
    }
    grid[row][col] = 0;
  }

  void _removeNumbers() {
    Random random = Random();
    while (attempts > 0) {
      int row = random.nextInt(9);
      int col = random.nextInt(9);
      if (grid[row][col] != 0) {
        int backup = grid[row][col];
        grid[row][col] = 0;
        List<List<int>> copyGrid = List.from(grid);
        counter = 0;
        _solveGrid();
        if (counter != 1) {
          setState(() {
            grid[row][col] = backup;
            attempts--;
          });
        }
      }
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
