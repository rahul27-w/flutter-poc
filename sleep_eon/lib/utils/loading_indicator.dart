import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  static void show(String status) async {
    if (!EasyLoading.isShow) {
      await EasyLoading.show(
        status: status,
        maskType: EasyLoadingMaskType.black,
      );
    }
  }

  static void dismiss() async {
    if (EasyLoading.isShow) {
      await EasyLoading.dismiss();
    }
  }
}
