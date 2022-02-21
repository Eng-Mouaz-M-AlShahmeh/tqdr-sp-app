/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
import 'package:tqdr_service_provider/screens/home/index.dart';
import 'package:tqdr_service_provider/styles/theme.dart';

Future<bool> onErrorAmount(BuildContext context, String text) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            text,
            style: yesDeleteButtonText,
            textAlign: TextAlign.right,
          ),
          content: const Text(''),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  'موافق',
                  style: categoryText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ) ??
      false;
}

Future<bool> onSubmitAmount(BuildContext context, String text) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            text,
            style: notificationText,
            textAlign: TextAlign.right,
          ),
          content: const Text(''),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: GestureDetector(
                onTap: () {
                  done(context);
                },
                child: Text(
                  'نعم',
                  style: submitText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  'لا',
                  style: noDeleteButtonText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
