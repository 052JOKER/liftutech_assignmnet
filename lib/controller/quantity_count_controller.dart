import 'package:flutter/foundation.dart';

class QuantityCountController extends ChangeNotifier{
  int _count=0;
  int get count => _count;

  void incrementCount(){
    _count++;
    notifyListeners();
  }
  void decrementCount(){
    if(_count>0){
      _count--;
    }
    notifyListeners();
  }
}