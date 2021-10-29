import 'package:flutter/material.dart';
import 'package:flutter_opinion_moniter/_utils/colors.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;

  const LoginButton(
      {Key? key,
      required this.title,
      this.enable = true,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          height: 45,
          onPressed: enable ? onPressed : null,
          disabledColor: HiColors.pink.shade200,
          color: HiColors.pink,
          child:
              Text(title, style: TextStyle(fontSize: 16, color: Colors.white))),
    );
  }
}
