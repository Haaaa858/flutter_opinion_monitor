import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/_utils/logger.dart';
import 'package:flutter_opinion_monitor/_utils/navigator/hi_navigator.dart';
import 'package:flutter_opinion_monitor/widgets/hi_app_bar.dart';
import 'package:flutter_opinion_monitor/widgets/login_button.dart';
import 'package:flutter_opinion_monitor/widgets/login_effect.dart';
import 'package:flutter_opinion_monitor/widgets/login_input.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool pwdFocused = false;
  onJumpToLogin() {
    HiNavigator.getInstance().onJumpTo(RouteStatus.login);
  }

  void pwdFocusChanged(isFocused) {
    setState(() {
      this.pwdFocused = isFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hiAppBar(
          title: "注册", rightTitle: "登录", rightButtonClick: onJumpToLogin),
      body: Container(
          child: ListView(
        children: [
          LoginEffect(
            protect: this.pwdFocused,
          ),
          LoginInput(
            title: "订单号",
            hint: "请输入订单号",
            keyboardType: TextInputType.number,
            onChanged: (value) {
              log(value);
            },
          ),
          LoginInput(
            title: "用户ID",
            hint: "请输入慕课网用户ID",
            keyboardType: TextInputType.number,
            onChanged: (value) {
              log(value);
            },
          ),
          LoginInput(
            title: "用户名",
            hint: "请输入用户名",
            onChanged: (value) {
              log(value);
            },
          ),
          LoginInput(
            title: "用户密码",
            hint: "请输入用户密码",
            obscureText: true,
            focusChanged: pwdFocusChanged,
            onChanged: (value) {
              log(value);
            },
          ),
          LoginInput(
            title: "确认密码",
            hint: "请再次输入密码",
            obscureText: true,
            focusChanged: pwdFocusChanged,
            onChanged: (value) {
              log(value);
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: LoginButton(
                title: "注册",
                onPressed: () {
                  log("login button click");
                }),
          )
        ],
      )),
    );
  }
}
