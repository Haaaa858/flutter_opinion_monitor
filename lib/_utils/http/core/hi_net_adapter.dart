import 'dart:convert';

import 'package:flutter_opinion_monitor/_utils/http/request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest baseRequest);
}

class HiNetResponse<T> {
  T? data;
  int? statusCode;
  String? statusMessage;
  BaseRequest request;
  dynamic extra;

  HiNetResponse(
      {this.data,
      required this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  @override
  String toString() {
    if (data is Map) {
      return 'HiNetResponse{data: ${json.encode(data)}}';
    }
    return 'HiNetResponse{data: $data}';
  }
}
