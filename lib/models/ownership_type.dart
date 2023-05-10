class OwnershipType {
  int? ownershipTypeId;
  String? ownershipTypeName;

  OwnershipType({this.ownershipTypeId, this.ownershipTypeName});

  factory OwnershipType.fromJson(Map<String, dynamic> json) {
    return OwnershipType(ownershipTypeId: json['ownershipTypeId'], ownershipTypeName: json['ownershipTypeName']);
  }

  Map<String, dynamic> toJson() {
    return {'ownershipTypeId': ownershipTypeId, 'ownershipTypeName': ownershipTypeName};
  }
}