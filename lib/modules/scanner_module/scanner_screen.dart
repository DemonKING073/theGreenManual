import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:scan/scan.dart';
import 'package:the_green_manual/common/ui/ui_helpers.dart';
import 'package:the_green_manual/constants/constant.dart';

import 'package:the_green_manual/core/services/toast_service.dart';

import 'package:the_green_manual/main.dart';
import 'package:validators/validators.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<ScannerScreen> {
  final qrKey = GlobalKey(debugLabel: "QR");

  bool isFlashon = false;

  ScanController scanController = ScanController();

  ScanController qrController = ScanController();

  // @override
  // void reassemble() async {
  //   super.reassemble();

  //   if (Platform.isAndroid) {
  //     await qrController!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     qrController!.resumeCamera();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'SCAN',
            style: LBoldTextStyle().copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: primaryColor,
        body: Stack(
          children: [
            ScanView(
              controller: qrController,
              scanAreaScale: .7,
              scanLineColor: Colors.green.shade400,
              onCapture: (data) {
                qrController.pause();
                // do something
                if (isMongoId(data)) {
                  // ToastService().s("Found");
                  navigatorKey.currentState!
                      .popAndPushNamed("/scanner_result", arguments: data);
                } else {
                  ToastService().w("Product not found!");
                  qrController.resume();
                }
              },
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height * .22,
              child: const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Place QR In The Scanner",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ),
            Positioned.fill(
              right: 15,
              // left: 30,
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        qrController.toggleTorchMode();
                      },
                      icon: Icon(
                        isFlashon == true ? Icons.flash_on : Icons.flash_off,
                        color: Colors.grey,
                      ),
                    ),
                    sHeightSpan,
                    IconButton(
                      onPressed: () async {
                        qrController.pause();
                        // List<Media>? res = await ImagesPicker.pick();
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          final file = File(result.files.single.path!);
                          String? str = await Scan.parse(file.path);
                          if (str == null) {
                            ToastService().w("Qr not found!");
                            qrController.resume();
                            return;
                          }
                          if (isMongoId(str)) {
                            // ToastService().s("Found");
                            navigatorKey.currentState!.popAndPushNamed(
                                "/scanner_result",
                                arguments: str);
                          } else {
                            ToastService().w("Product not found!");
                            qrController.resume();
                          }
                        } else {
                          // User canceled the picker
                          ToastService().w("Cancelled by the user!");
                        }
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
