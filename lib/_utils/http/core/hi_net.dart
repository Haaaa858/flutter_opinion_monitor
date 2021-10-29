import 'package:flutter_opinion_moniter/_utils/http/core/dio_adapter.dart';
import 'package:flutter_opinion_moniter/_utils/http/core/hi_error.dart';
import 'package:flutter_opinion_moniter/_utils/http/core/hi_net_adapter.dart';
import 'package:flutter_opinion_moniter/_utils/http/request/base_request.dart';
import 'package:flutter_opinion_moniter/_utils/logger.dart';

class HiNet {
  HiNet._();

  static HiNet? _instance;

  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance!;
  }

  Future fire(BaseRequest baseRequest) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(baseRequest);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      log(e.data.toString());
    } catch (e) {
      error = e;
      log(error.toString());
    }

    if (response == null) {
      log(error.toString());
    }
    var result = response?.data;
    var status = response?.statusCode;

    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin("需要登录");
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        log(result.toString());
        throw HiNetError(status ?? -1, result.toString());
    }
  }

  Future<HiNetResponse<T>> send<T>(BaseRequest baseRequest) async {
    log("url: ${baseRequest.url()} method: ${baseRequest.httpMethod()}");
    HiNetAdapter adapter = DioAdapter();
    Future<HiNetResponse<T>> response = adapter.send(baseRequest);
    return response;
  }
}
