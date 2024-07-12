// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DisclaimerProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  bool _isDisclaimerAccepted = false;

  bool get isDisclaimerAccepted => _isDisclaimerAccepted;

  DisclaimerProvider() {
    _loadDisclaimerStatus();
  }

  Future<void> _loadDisclaimerStatus() async {
    String? isAccepted = await _storage.read(key: 'disclaimerAccepted');
    _isDisclaimerAccepted = isAccepted == 'true';
    notifyListeners();
  }

  void setDisclaimerStatus(bool status) async {
    _isDisclaimerAccepted = status;
    await _storage.write(key: 'disclaimerAccepted', value: status.toString());
    notifyListeners();
  }

  void acceptDisclaimer() async {
    setDisclaimerStatus(true);
  }

  void revokeDisclaimer() async {
    setDisclaimerStatus(false);
  }
}
