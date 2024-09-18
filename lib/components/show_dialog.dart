import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ShowAllDialog {
  //Close All Dialog boxes
  static void hideDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  //Show Loading Dialog
  static void showLoadiingDialog(double width) {
    Get.dialog(
      Center(
        child: Container(
          height: 100,
          width: width * 0.6,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Loading......",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10),
              SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
