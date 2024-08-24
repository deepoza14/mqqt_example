import 'dart:developer';

import 'package:flutter/material.dart';
import '../../main.dart';

void showSnackBar(BuildContext context, {required String content, SnackBarAction? snackBarAction}) {
  final scaffold = ScaffoldMessenger.of(context);
  log("Snacbar Called");
  scaffold.hideCurrentSnackBar();
  scaffold.showSnackBar(
    SnackBar(
      elevation: 6,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Row(
        children: [
          const Icon(
            Icons.info,
            color: Colors.white,
          ), // Add your icon here
          const SizedBox(width: 15), // Add some spacing between the icon and text
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 5000),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      behavior: SnackBarBehavior.floating,
      // Change behavior to floating

      action: snackBarAction,
    ),
  );
}
