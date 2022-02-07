import 'package:flutter/material.dart';

class Utils {
  snackShow(BuildContext context, String contextstr) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(contextstr),
    ));
  }
}
