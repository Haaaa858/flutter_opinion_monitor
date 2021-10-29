import 'package:flutter/material.dart';
import 'package:flutter_opinion_moniter/widgets/single_line_fitted_box.dart';

enum HeaderBgPos { LEFT, CENTER, RIGHT }

class LoginEffect extends StatelessWidget {
  final bool protect;

  final String leftUri = "assets/images/head_left.png";
  final String leftProtectUri = "assets/images/head_left_protect.png";
  final String centerUri = "assets/images/logo.png";
  final String rightUri = "assets/images/head_right.png";
  final String rightProtectUri = "assets/images/head_right_protect.png";

  const LoginEffect({Key? key, required this.protect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        child: SingleLineFittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _image(HeaderBgPos.LEFT),
              _image(HeaderBgPos.CENTER, width: 90),
              _image(HeaderBgPos.RIGHT)
            ],
          ),
        ));
  }

  _image(HeaderBgPos pos, {double? width, double height = 90.0}) {
    String src = "";
    switch (pos) {
      case HeaderBgPos.LEFT:
        src = !protect ? leftUri : leftProtectUri;
        break;
      case HeaderBgPos.CENTER:
        src = centerUri;
        break;
      case HeaderBgPos.RIGHT:
        src = !protect ? rightUri : rightProtectUri;
        break;
    }
    return Image(height: height, width: width, image: AssetImage(src));
  }
}
