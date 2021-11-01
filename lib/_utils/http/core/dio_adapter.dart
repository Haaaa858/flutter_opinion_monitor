import 'package:dio/dio.dart';
import 'package:flutter_opinion_monitor/_utils/http/core/hi_error.dart';
import 'package:flutter_opinion_monitor/_utils/http/core/hi_net_adapter.dart';
import 'package:flutter_opinion_monitor/_utils/http/request/base_request.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest baseRequest) async {
    return Future<HiNetResponse<T>>.delayed(Duration(milliseconds: 1000),
        () async {
      var response, option = Options(headers: baseRequest.header);
      var error;
      try {
        switch (baseRequest.httpMethod()) {
          case HttpMethod.GET:
            response = await Dio().get(baseRequest.url(),
                queryParameters: baseRequest.params, options: option);
            break;
          case HttpMethod.POST:
            response = await Dio().post(baseRequest.url(),
                queryParameters: baseRequest.params, options: option);
            break;
          case HttpMethod.DELETE:
            response = await Dio().delete(baseRequest.url(),
                data: baseRequest.params, options: option);
        }
      } on DioError catch (e) {
        error = e;
        response = e.response;
      }
      if (error != null) {
        throw HiNetError(response.statusCode, error.toString(),
            data: await buildRes(response, baseRequest));
      }

      return buildRes(response, baseRequest);
    });
  }

  Future<HiNetResponse<T>> buildRes<T>(
      Response? response, BaseRequest request) {
    return Future.value(HiNetResponse(
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }
}
