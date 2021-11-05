import 'package:flutter/material.dart';
import 'package:flutter_opinion_monitor/_utils/navigator/hi_navigator.dart';
import 'package:flutter_opinion_monitor/model/home_mo.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;
  const HiBanner(
      {Key? key,
      required this.bannerList,
      this.bannerHeight = 160,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 6)),
    );
  }

  _image(BannerMo banner) {
    return InkWell(
      onTap: () {
        _handleClick(banner);
      },
      child: Container(
        padding: this.padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(banner.cover, fit: BoxFit.cover),
        ),
      ),
    );
  }

  void _handleClick(BannerMo banner) {
    if (banner.type == "video") {
      HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
          args: {"videoMo": VideoMo(vid: banner.url)});
    } else {
      print(banner.toString());
    }
  }
}
