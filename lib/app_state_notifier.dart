import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  String current = "";

  void setName(name) {
    current = name;
    notifyListeners();
  }

}
