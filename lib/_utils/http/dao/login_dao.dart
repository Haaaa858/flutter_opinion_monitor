import 'package:flutter_opinion_monitor/_utils/http/core/hi_cache.dart';
import 'package:flutter_opinion_monitor/_utils/http/core/hi_net.dart';
import 'package:flutter_opinion_monitor/_utils/http/request/base_request.dart';
import 'package:flutter_opinion_monitor/_utils/http/request/login_request.dart';
import 'package:flutter_opinion_monitor/_utils/http/request/registration_request.dart';

class LoginDao {
  static final String BOARDING_PASS = "boarding-pass";

  static login(String username, String password) {
    return _send(username, password);
  }

  static registration(
      String username, String password, String imoocId, String orderId) {
    return _send(username, password, imoocId: imoocId, orderId: orderId);
  }

  static _send(String username, String password, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
      request.add(imoocId, imoocId).add(orderId, orderId);
    } else {
      request = LoginRequest();
    }
    request.add("userName", username).add("password", password);

    var result = await HiNet.getInstance().fire(request);
    if (result["code"] == 0 && result["data"] != null) {
      HiCache.getInstance().setString(BOARDING_PASS, result["data"]);
    }
    return result;
  }

  static String? getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }

  static bool isLogin() {
    String? token = HiCache.getInstance().get(BOARDING_PASS);
    return token != null;
  }
}
