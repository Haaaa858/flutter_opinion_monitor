class Result {
  late bool success;
  late int code;
  late String method;
  late String requestPrams;

  Result(this.success, this.code, this.method, this.requestPrams);

  factory Result.fromJson(Map<String, dynamic> json) {
    bool _success = (json['code'] as int) == 0;
    return Result(
      _success,
      json['code'] as int,
      json['method'] as String,
      json['requestPrams'] as String,
    );
  }

  Map<String, dynamic> toJson(Result instance) {
    return {
      "success": instance.success,
      'code': instance.code,
      'method': instance.method,
      'requestPrams': instance.requestPrams,
    };
  }
}
