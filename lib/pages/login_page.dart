import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_opinion_moniter/_utils/http/core/hi_cache.dart';
import 'package:flutter_opinion_moniter/_utils/http/dao/login_dao.dart';
import 'package:flutter_opinion_moniter/pages/registration_page.dart';
import 'package:flutter_opinion_moniter/widgets/hi_app_bar.dart';
import 'package:flutter_opinion_moniter/widgets/login_button.dart';
import 'package:flutter_opinion_moniter/widgets/login_effect.dart';
import 'package:flutter_opinion_moniter/widgets/login_input.dart';
import 'package:logging/logging.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool pwdFocused = false;
  String? username;
  String? password;
  final Logger logger = Logger("LoginPageState");

  void pwdFocusChanged(isFocused) {
    setState(() {
      this.pwdFocused = isFocused;
    });
  }

  bool getSubmitEnable() {
    return !TextUtil.isEmpty(username) && !TextUtil.isEmpty(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hiAppBar(
        title: "登录",
        rightTitle: "注册",
        rightButtonClick: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return RegistrationPage();
          }));
        },
      ),
      body: Container(
          child: ListView(
        children: [
          LoginEffect(
            protect: this.pwdFocused,
          ),
          LoginInput(
            title: "用户名",
            hint: "请输入用户名",
            onChanged: (value) {
              setState(() {
                this.username = value;
              });
            },
          ),
          LoginInput(
            title: "用户密码",
            hint: "请输入用户密码",
            obscureText: true,
            focusChanged: pwdFocusChanged,
            onChanged: (value) {
              setState(() {
                this.password = value;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: LoginButton(
                title: "登录",
                enable: getSubmitEnable(),
                onPressed: () {
                  submit();
                }),
          )
        ],
      )),
    );
  }

  void submit() async {
    var result = await LoginDao.login(username!, password!);
    logger.info("login response,${result.toString()}");

    logger.info(
        "${LoginDao.BOARDING_PASS},${HiCache.getInstance().get(LoginDao.BOARDING_PASS)}");
  }
}
