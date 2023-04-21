class Establishment {
  String? establishmentName;
  int? ownerShipTypeId;
  int? regionId;
  int? districtId;
  String? locality;
  String? address;
  String? phoneNumber;
  String? email;
  int? establishmentTypeId;
  int? industryId;
  int? accomodationTypeId;
  String? mainActivityUndertaken;
  DateTime? businessRegistrationDate;
  String? registrationPlace;
  DateTime? businessCommencementDate;

  Establishment(
      {this.establishmentName,
      this.ownerShipTypeId,
      this.regionId,
      this.districtId,
      this.locality,
      this.address,
      this.phoneNumber,
      this.email,
      this.establishmentTypeId,
      this.industryId,
      this.accomodationTypeId,
      this.mainActivityUndertaken,
      this.businessRegistrationDate,
      this.registrationPlace,
      this.businessCommencementDate});

  factory Establishment.fromJson(Map<String, dynamic> json) {
    return Establishment(
        establishmentName: json['establishmentName'],
        ownerShipTypeId: json['ownerShipTypeId'],
        regionId: json['regionId'],
        districtId: json['districtId'],
        locality: json['locality'],
        address: json['address'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        establishmentTypeId: json['establishmentTypeId'],
        industryId: json['industryId'],
        accomodationTypeId: json['accomodationTypeId'],
        mainActivityUndertaken: json['mainActivityUndertaken'],
        businessRegistrationDate:
            DateTime.parse(json['businessRegistrationDate']),
        registrationPlace: json['registrationPlace'],
        businessCommencementDate:
            DateTime.parse(json['businessCommencementDate']));
  }

  Map<String, dynamic> toJson() {
    return {
      'establishmentName': establishmentName,
      'ownerShipTypeId': ownerShipTypeId,
      'regionId': regionId,
      'districtId': districtId,
      'locality': locality,
      'address': address,
      'phoneNumber': phoneNumber,
      'email': email,
      'establishmentTypeId': establishmentTypeId,
      'industryId': industryId,
      'accomodationTypeId': accomodationTypeId,
      'mainActivityUndertaken': mainActivityUndertaken,
      'businessRegistrationDate': businessRegistrationDate?.toIso8601String().replaceAll('.000', ''),
      'registrationPlace': registrationPlace,
      'businessCommencementDate': businessCommencementDate?.toIso8601String().replaceAll('.000', ''),
    };
  }
}
