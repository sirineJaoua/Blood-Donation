import 'package:flutter/foundation.dart';

class Notification {
  final String msg;
  Notification(this.msg);
}

class NotificationProvider with ChangeNotifier {
  late Notification _notif;
  final List<Notification> _notifactionS = [];

  Notification get notif => _notif;
  List<Notification> get notifications => _notifactionS;

  void updateNotification(String msg) {
    _notif = Notification(msg);
    _notifactionS.add(_notif);

    notifyListeners();
  }
}
