import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressModel with ChangeNotifier {
  double _progress = 0.0;

  double get progress => _progress;

  void increaseProgress(double value) {
    _progress += value;
    if (_progress > 1.0) _progress = 1.0;
    notifyListeners();
  }

  void resetProgress() {
    _progress = 0.0;
    notifyListeners();
  }
}
