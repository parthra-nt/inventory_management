import 'package:flutter/cupertino.dart';
import 'package:untitled/presentation/screens/home/home_screen.dart';

class BottomNavBarProvider extends ChangeNotifier {
  List<Widget> pages = [
    HomeWebScreen(),
    Center(child: Text("Items")),
    Center(child: Text("Transactions")),
  ];

  int _index = 0;
  int get index => _index;
  void setIndex(int value) {
    _index = value;
    notifyListeners();
  }
}
