
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToaster {
  static void showToaster(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(196, 7, 7, 7),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
