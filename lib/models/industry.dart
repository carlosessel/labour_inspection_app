class Industry {
  int? industryId;
  String? industryName;

  Industry({this.industryId, this.industryName});

  factory Industry.fromJson(Map<String, dynamic> json) {
    return Industry(industryId: json['industryId'], industryName: json['industryName']);
  }

  Map<String, dynamic> toJson() {
    return {'industryId': industryId, 'industryName': industryName};
  }
}