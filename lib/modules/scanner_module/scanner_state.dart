import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerState extends ChangeNotifier {
  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;
}
