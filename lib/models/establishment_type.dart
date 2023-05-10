class EstablishmentType {
  int? establishmentTypeId;
  String? establishmentTypeName;

  EstablishmentType({this.establishmentTypeId, this.establishmentTypeName});

  factory EstablishmentType.fromJson(Map<String, dynamic> json) {
    return EstablishmentType(establishmentTypeId: json['establishmentTypeId'], establishmentTypeName: json['establishmentTypeName']);
  }

  Map<String, dynamic> toJson() {
    return {'establishmentTypeId': establishmentTypeId, 'establishmentTypeName': establishmentTypeName};
  }
}