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

  /// Returns true if the ViewModel is waiting for an async operation to finish.
  bool get busy => _busy;
  set busy(bool value) {
    _busy = value;
    forceNotify();
  }

  /// Notifies listeners that a (potentially long) async operation has started.
  /// When the operation finishes, listeners will be notified once again.
  Future<dynamic> load(Future<dynamic> task) async {
    busy = true;
    dynamic result = await task;
    busy = false;
    return result;
  }

  /// Notifies listeners that the ViewModel data has changed.
  forceNotify() => this.notifyListeners();

  void init();
}
