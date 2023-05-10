class AccommodationType {
  int? accommodationTypeId;
  String? accommodationTypeName;

  AccommodationType({this.accommodationTypeId, this.accommodationTypeName});

  factory AccommodationType.fromJson(Map<String, dynamic> json) {
    return AccommodationType(accommodationTypeId: json['accommodationTypeId'], accommodationTypeName: json['accommodationTypeName']);
  }

  Map<String, dynamic> toJson() {
    return {'accommodationTypeId': accommodationTypeId, 'accommodationTypeName': accommodationTypeName};
  }
}