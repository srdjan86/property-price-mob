import 'package:flutter/material.dart';

abstract class BaseViewModel extends ChangeNotifier {
  String _error;
  String get error => _error;
  @protected
  set error(String value) {
    _error = value;
    forceNotify();
  }

  @protected
  void clearError() {
    error = null;
  }

  bool _busy = false;

  bool get busy => _busy;
  set busy(bool value) {
    _busy = value;
    forceNotify();
  }

  Future<dynamic> load(Future<dynamic> task) async {
    busy = true;
    dynamic result = await task;
    busy = false;
    return result;
  }

  forceNotify() => this.notifyListeners();

  void init();
}
