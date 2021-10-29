import 'package:flutter/material.dart';
import 'package:flutter_opinion_moniter/_utils/colors.dart';
import 'package:flutter_opinion_moniter/_utils/logger.dart';

class LoginInput extends StatefulWidget {
  // 标题
  final String title;
  // 输入框内提示文字
  final String? hint;

  final ValueChanged<String>? onChanged;

  final ValueChanged<bool>? focusChanged;

  // 分割线
  final bool lineStretch;

  // 文字保护
  final bool obscureText;

  // 键盘类型
  final TextInputType? keyboardType;

  LoginInput(
      {Key? key,
      required this.title,
      this.hint,
      this.onChanged,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      log("Has focus: ${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 100,
              padding: EdgeInsets.only(left: 15),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          child: Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  Widget _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      autofocus: !widget.obscureText,
      cursorColor: HiColors.pink,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }
}
