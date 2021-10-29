import 'package:flutter_opinion_moniter/_utils/http/request/base_request.dart';

class LoginRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    // TODO: implement httpMethod
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    // TODO: implement needLogin
    return false;
  }

  @override
  String path() {
    // TODO: implement path
    return "uapi/user/login";
  }
}
