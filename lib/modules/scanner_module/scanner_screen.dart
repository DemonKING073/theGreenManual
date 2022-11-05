import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:the_green_manual/constants/constant.dart';

import 'package:the_green_manual/core/services/toast_service.dart';
import 'package:the_green_manual/main.dart';
import 'package:the_green_manual/modules/scanner_module/scanner_state.dart';
import 'package:validators/validators.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<ScannerScreen> {
  final qrKey = GlobalKey(debugLabel: "QR");

  bool isFlashon = false;

  Barcode? barcode;

  QRViewController? qrController;
  static bool canPop(BuildContext context) {
    final NavigatorState? navigator = Navigator.maybeOf(context);
    return navigator != null && navigator.canPop();
  }

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
    final state = Provider.of<ScannerState>(context);

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
            buildQrView(context),
            // Positioned.fill(
            //   top: 20,
            //   left: 20,
            //   child: Align(
            //     alignment: Alignment.topLeft,
            //     child: InkWell(
            //       onTap: () {
            //         if (canPop(context) == true) {
            //           navigatorKey.currentState!.pop();
            //         }
            //       },
            //       child: const SizedBox(
            //         height: 40,
            //         width: 40,
            //         child: Center(
            //           child: Icon(
            //             Icons.arrow_back,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height * .28,
              child: const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Place QR In The Scanner",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              right: 15,
              // left: 30,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (!isFlashon == true) {
                        qrController!.toggleFlash();
                      } else {
                        qrController!.toggleFlash();
                      }
                      isFlashon = !isFlashon;
                    });
                  },
                  icon: Icon(
                    isFlashon == true ? Icons.flash_on : Icons.flash_off,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    if (qrController != null && mounted) {
      qrController!.resumeCamera();
    }
    return QRView(
      cameraFacing: CameraFacing.back,
      key: qrKey,
      
      onQRViewCreated: onQrViewCreated,
      overlay: QrScannerOverlayShape(
        overlayColor: Colors.black.withOpacity(0.8),
        
        borderColor: primaryColor,
        borderRadius: 10,
        borderWidth: 4,
        cutOutSize: MediaQuery.of(context).size.width * 0.6,
      ),
    );
  }

  void onQrViewCreated(QRViewController controller) {
    setState(() => qrController = controller);

    controller.scannedDataStream.listen((event) {
      setState(() {
        barcode = event;
        qrController!.pauseCamera();
        if (isMongoId(barcode!.code!)) {
          // ToastService().s("Found");
          navigatorKey.currentState!
              .popAndPushNamed("/scanner_result", arguments: barcode!.code);
        } else {
          ToastService().w("Product not found!");
          qrController!.resumeCamera();
        }
      });
    });
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }
}
