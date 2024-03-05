import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmAlertDialog {
  static show(
      {required BuildContext context,
      required String tips,
      required int price,
      required Function? confirmCallback}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // 设置圆角半径
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          // insetPadding: EdgeInsets.only(top: 120),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text(
            'Purchase Props',
            style: TextStyle(
                fontSize: 22,
                color: Color(0xFF101828),
                fontFamily: 'Baloo2',
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Container(
            width: MediaQuery.of(context).size.width - 80,
            child: Text(
              tips,
              style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF101828),
                  fontFamily: 'Baloo2',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            Container(
              width: 90,
              height: 38,
              child: TextButton(
                  onPressed: () {
                    // 在按钮上执行操作并关闭对话框
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(
                          color: Color(0xffCFD1D4), width: 1.0),
                    ),
                  )),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Color(0xff9FA3A9),
                        fontFamily: 'Baloo2',
                        fontSize: 15),
                  )),
            ),
            Container(
              width: 90,
              height: 38,
              child: TextButton(
                  onPressed: () {
                    confirmCallback?.call();
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFF6737)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                              color: Color(0xFFFF6737), width: 1.0),
                        ),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.child_care_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        price.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Baloo2',
                            fontSize: 15),
                      )
                    ],
                  )),
            ),
          ],
        );
      },
    );
  }
}
