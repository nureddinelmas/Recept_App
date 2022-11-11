import 'package:flutter/material.dart';

class Utils {
  void snackbar(context, String enterText) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(enterText),
        action: SnackBarAction(
            label: "Undo", onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void showAlertDialog(context, email) {
    AlertDialog alert = AlertDialog(
      content: Text(
        "An reset email is sent to $email",
        style: const TextStyle(fontFamily: "Times"),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
