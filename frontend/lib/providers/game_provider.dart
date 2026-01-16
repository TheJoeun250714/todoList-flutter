import 'package:flutter/cupertino.dart';

class GameProvider with ChangeNotifier {
  int _score = 0;

  int get score => _score;

  void addScore() {
    _score += 10;
    notifyListeners();
  }
}

