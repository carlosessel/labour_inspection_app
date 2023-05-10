class District {
  int? districtId;
  String? districtName;
  String? districtCode;

  District({this.districtId, this.districtName, this.districtCode});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
        districtId: json['districtId'],
        districtName: json['districtName'],
        districtCode: json['districtCode']);
  }

  Map<String, dynamic> toJson() {
    return {
      'districtId': districtId,
      'districtName': districtName,
      'districtCode': districtCode
    };
  }
}









