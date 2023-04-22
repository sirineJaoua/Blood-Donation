import 'package:flutter/foundation.dart';

class BloodOrder {
  final int amount;
  final String date;
  final String type;

  BloodOrder(this.amount, this.date, this.type);
}

class BloodOrderProvider with ChangeNotifier {
  late BloodOrder _bloodOrder;
  final List<BloodOrder> _bloodOrderS = [];

  BloodOrder get bloodOrder => _bloodOrder;
  List<BloodOrder> get bloodOrderS => _bloodOrderS;

  void updateBloodOrder(int amount, String date, String type) {
    _bloodOrder = BloodOrder(amount, date, type);
    _bloodOrderS.add(_bloodOrder);
    notifyListeners();
  }
}
