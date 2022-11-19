import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/models.dart';

void showErrorDialog(BuildContext ctx, CustomError err) {
  if (kDebugMode) {
    print('code: ${err.code}\nmessage: ${err.message}\n${err.plugin}');
  }

  if (Platform.isIOS) {
    showCupertinoDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(err.code),
        content: Text('${err.plugin}\n${err.message}'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  if (Platform.isAndroid) {
    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(err.code),
        content: Text('${err.plugin}\n${err.message}'),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }
}
