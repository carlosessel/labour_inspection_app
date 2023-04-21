import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/establishment.dart';

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
}
