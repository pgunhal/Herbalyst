import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DisclaimerProvider with ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _isDisclaimerAccepted = false;

  bool get isDisclaimerAccepted => _isDisclaimerAccepted;

  DisclaimerProvider() {
    _loadDisclaimerStatus();
  }

  void _loadDisclaimerStatus() async {
    String? isAccepted = await _storage.read(key: 'disclaimerAccepted');
    _isDisclaimerAccepted = isAccepted == 'true';
    notifyListeners();
  }

  void acceptDisclaimer() async {
    _isDisclaimerAccepted = true;
    await _storage.write(key: 'disclaimerAccepted', value: 'true');
    notifyListeners();
  }

  void revokeDisclaimer() async {
    _isDisclaimerAccepted = false;
    await _storage.write(key: 'disclaimerAccepted', value: 'false');
    notifyListeners();
  }
}
