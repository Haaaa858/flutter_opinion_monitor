import 'package:flutter_opinion_monitor/_utils/http/core/hi_net.dart';
import 'package:flutter_opinion_monitor/_utils/http/request/home_request.dart';
import 'package:flutter_opinion_monitor/model/home_mo.dart';

class HomeDao {
  static Future<HomeMo> get(String categoryName,
      {int pageIndex = 1, pageSize = 10}) async {
    HomeRequest request = HomeRequest();
    request.pathParams = categoryName;
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    return HomeMo.fromJson(result["data"]);
  }
}
