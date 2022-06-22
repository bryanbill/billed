import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget qrWidget(BuildContext context, String data) {
  return Align(
      alignment: Alignment.center,
      child: Container(
          width: 250,
          height: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColorLight),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: QrImage(
            data: data,
            size: 240,
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
            ),
            eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
            foregroundColor: Theme.of(context).primaryColorDark,
            backgroundColor: Colors.white,
          )));
}