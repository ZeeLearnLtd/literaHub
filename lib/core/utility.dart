import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'theme/light_colors.dart';

class Utility {
  static showLoaderDialog(BuildContext context) {
    print('loader start------------');
    AlertDialog alert = AlertDialog(
      content: Lottie.asset('assets/json/apploader.json'),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Colors.transparent),
          child: alert,
        );
      },
    );
  }

  static showLoader() {
    return Center(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Lottie.asset('assets/json/apploader.json')));
  }

  static showAlert(BuildContext context, String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
              style: ElevatedButton.styleFrom(
                  elevation: 10.0,
                  textStyle: TextStyle(color: kPrimaryLightColor)),
              child: Text(
                'OK',
                style: LightColors.textSmallHightliteStyle,
              ),
            ),
          ],
        );
      },
    );
  }

  static getGridViewStyle() {
    return kIsWeb
        ? const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: kIsWeb ? 4 : 2,
            // Set the aspect ratio of each card.
            childAspectRatio: 3 / 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            /*crossAxisCount: 2,
                        childAspectRatio: 2,*/
          )
        : const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
          );
  }
}
