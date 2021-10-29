class Owner {
  late String name;
  late String face;
  late int fans;

  Owner(this.name, this.face, this.fans);

  Owner.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    face = json["face"];
    fans = json["fans"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map();
    data["name"] = this.name;
    data["name"] = this.name;
    data["name"] = this.name;
    return data;
  }
}
