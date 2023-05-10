import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/accommodation_type.dart';
import '../models/district.dart';
import '../models/establishment.dart';
import '../models/establishment_Type.dart';
import '../models/industry.dart';
import '../models/ownership_type.dart';
import '../models/region.dart';

class LabourInspectionApi {
  static const String apiUrl = "https://localhost:7283/api";

  //Get Establishments
  static Future<List<Establishment>> getEstablishments() async {
    const url = '$apiUrl/establishments';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Establishment> establishments =
          body.map((dynamic item) => Establishment.fromJson(item)).toList();
      return establishments;
    } else {
      throw Exception('Failed to load items');
    }
  }


  //Create Establishment
  static Future<Establishment> createEstablishment(
      Establishment establishment) async {
    const url = '$apiUrl/establishments';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(establishment.toJson()),
    );

    if (response.statusCode == 201) {
      return Establishment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create establishment: ${response.body}');
    }
  }



  //Get EstablishmentTypes
  static Future<List<EstablishmentType>> getEstablishmentTypes() async {
    const url = '$apiUrl/establishmenttypes';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<EstablishmentType> establishmenttypes =
          body.map((dynamic item) => EstablishmentType.fromJson(item)).toList();
      return establishmenttypes;
    } else {
      throw Exception('Failed to load items');
    }
  }

  //Get OwnershipTypes
  static Future<List<OwnershipType>> getOwnershipTypes() async {
    const url = '$apiUrl/ownershiptypes';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<OwnershipType> ownershiptypes =
          body.map((dynamic item) => OwnershipType.fromJson(item)).toList();
      return ownershiptypes;
    } else {
      throw Exception('Failed to load items');
    }
  }

  //Get AccommodationTypes
  static Future<List<AccommodationType>> getAccommodationTypes() async {
    const url = '$apiUrl/accommodationtypes';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<AccommodationType> accommodationtypes =
          body.map((dynamic item) => AccommodationType.fromJson(item)).toList();
      return accommodationtypes;
    } else {
      throw Exception('Failed to load items');
    }
  }

  //Get Districts
  static Future<List<District>> getDistricts() async {
    const url = '$apiUrl/districts';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<District> districts =
          body.map((dynamic item) => District.fromJson(item)).toList();
      return districts;
    } else {
      throw Exception('Failed to load items');
    }
  }

  //Get Regions
  static Future<List<Region>> getRegions() async {
    const url = '$apiUrl/regions';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Region> regions =
          body.map((dynamic item) => Region.fromJson(item)).toList();
      return regions;
    } else {
      throw Exception('Failed to load items');
    }
  }

  //Get Industries
  static Future<List<Industry>> getIndustries() async {
    const url = '$apiUrl/industries';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Industry> industries =
          body.map((dynamic item) => Industry.fromJson(item)).toList();
      return industries;
    } else {
      throw Exception('Failed to load items');
    }
  }
  
}
