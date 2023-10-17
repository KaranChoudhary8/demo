import 'package:expense/Settings/constaint.dart';
import 'package:flutter/cupertino.dart';

class RadioPicker extends ChangeNotifier{
  amountType _type = amountType.Earning;

  amountType get type => _type;
  void setType(amountType newType){
    _type = newType;
    notifyListeners();
  }
}