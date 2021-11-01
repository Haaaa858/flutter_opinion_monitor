import 'package:flutter_opinion_monitor/_utils/http/core/hi_net_adapter.dart';
import 'package:flutter_opinion_monitor/_utils/http/request/base_request.dart';

class NockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest baseRequest) async {
    return Future<HiNetResponse<T>>.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(
        data: {"b": 1} as T,
        request: baseRequest,
        statusCode: 200,
        statusMessage: "ok",
      );
    });
    // TODO: implement send
    throw UnimplementedError();
  }
}
