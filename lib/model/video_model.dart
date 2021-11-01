class VideoModel {
  late String vid;

  VideoModel({required this.vid});

  VideoModel.fromJson(Map<String, dynamic> json) {
    vid = json['vid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vid'] = this.vid;
    return data;
  }
}
