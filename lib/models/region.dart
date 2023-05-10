class Region {
  int? regionId;
  String? regionName;

  Region({this.regionId, this.regionName});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(regionId: json['regionId'], regionName: json['regionName']);
  }

  Map<String, dynamic> toJson() {
    return {'regionId': regionId, 'regionName': regionName};
  }
}