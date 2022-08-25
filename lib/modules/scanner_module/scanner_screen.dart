import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:the_green_manual/constants/constant.dart';
import 'package:the_green_manual/modules/scanner_module/scanner_state.dart';

class ScannerScreen extends StatelessWidget {
  static const String id = 'scannarScreen';

  const ScannerScreen({super.key});

  void onQRViewCreated(QRViewController controller) {}
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ScannerState>(context);

    Widget buildQrView(BuildContext context) {
      return QRView(key: state.qrKey, onQRViewCreated: onQRViewCreated);
    }

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          'SCAN',
          style: LBoldTextStyle().copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                'Place QR in the Scanner',
                style: kBoldTextStyle(),
              ),
              LSizedBox(),
              // buildQrView(context),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
