import 'package:flutter/material.dart';
import 'package:labour_inspection/models/establishment.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/accommodation_type.dart';
import '../models/district.dart';
import '../models/establishment_Type.dart';
import '../models/industry.dart';
import '../models/ownership_type.dart';
import '../models/region.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    const String createEstablishment = '''CREATE TABLE Establishment
          (
          establishmentId INTEGER PRIMARY KEY, 
          establishmentName TEXT NOT NULL UNIQUE,
          ownerShipTypeId INTEGER,	
          regionId INTEGER,	
          districtId INTEGER,	
          locality TEXT,	
          address TEXT,	
          phoneNumber TEXT,	
          email TEXT,	
          establishmentTypeId INTEGER,	
          industryId INTEGER,	
          accommodationTypeID INTEGER,
          mainActivityUndertaken TEXT,
          businessRegistrationDate DATE,
          registrationPlace TEXT,
          businessCommencementDate DATE
          )''';

    const String createDistrict = '''CREATE TABLE District
    (
      districtId INTEGER PRIMARY KEY,
      districtCode TEXT NOT NULL,
      districtName TEXT NOT NULL
    )''';

    const String createRegion = '''CREATE TABLE Region
    (
      regionId INTEGER PRIMARY KEY,
      regionName TEXT NOT NULL,
    )''';

    const String createIndustry = '''CREATE TABLE Industry
    (
      industryId INTEGER PRIMARY KEY,
      industryName TEXT NOT NULL,
    )''';

    const String createAccommodationType = '''CREATE TABLE AccommodationType
    (
      accommodationTypeId INTEGER PRIMARY KEY,
      accommodationTypeName TEXT NOT NULL,
    )''';

    const String createEstablishmentType = '''CREATE TABLE EstablishmentType
    (
      establishmentTypeId INTEGER PRIMARY KEY,
      establishmentTypeName TEXT NOT NULL,
    )''';

    const String createOwnershipType = '''CREATE TABLE OwnershipType
    (
      ownershipTypeId INTEGER PRIMARY KEY,
      ownershipTypeName TEXT NOT NULL,
    )''';


    //Create Establishment Table
    return openDatabase(
      join(path, 'app_database.db'),
      onCreate: (database, version) async {
        await database.execute(createEstablishment);
        await database.execute(createEstablishmentType);
        await database.execute(createDistrict);
        await database.execute(createRegion);
        await database.execute(createIndustry);
        await database.execute(createOwnershipType);
        await database.execute(createAccommodationType);
      },
      version: 1,
    );
  }

  //Insert Establishment
  Future<int> insertEstablishment(Establishment establishment) async {
    final Database db = await initializeDB();
    final id = await db.insert('Establishment', establishment.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //Get Establishment Data
  Future<List<Establishment>> getEstablishmentItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('Establishment');
    return queryResult.map((e) => Establishment.fromJson(e)).toList();
  }

  // Delete an establishment by id
  Future<void> deleteEstablishmentItem(int establishmentId) async {
    final db = await initializeDB();
    try {
      await db.delete("Establishment",
          where: "establishmentId = ?", whereArgs: [establishmentId]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  //Get District Data
  Future<List<District>> getDistrictItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('District');
    return queryResult.map((e) => District.fromJson(e)).toList();
  }


  //Insert District
  Future<int> insertDistrict(District district) async {
    final Database db = await initializeDB();
    final id = await db.insert('District', district.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //Get Region Data
  Future<List<Region>> getRegionItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('Region');
    return queryResult.map((e) => Region.fromJson(e)).toList();
  }


  //Insert Region
  Future<int> insertRegion(Region region) async {
    final Database db = await initializeDB();
    final id = await db.insert('Region', region.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //Get Industry Data
  Future<List<Industry>> getIndustryItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('Industry');
    return queryResult.map((e) => Industry.fromJson(e)).toList();
  }

  //Insert Industry
  Future<int> insertIndustry(Industry industry) async {
    final Database db = await initializeDB();
    final id = await db.insert('Industry', industry.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //Get AccommodationType Data
  Future<List<AccommodationType>> getAccommodationTypeItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('AccommodationType');
    return queryResult.map((e) => AccommodationType.fromJson(e)).toList();
  }

  //Insert AccommodationType
  Future<int> insertAccommodationType(AccommodationType accommodationType) async {
    final Database db = await initializeDB();
    final id = await db.insert('AccommodationType', accommodationType.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //Get EstablishmentType Data
  Future<List<EstablishmentType>> getEstablishmentTypeItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('EstablishmentType');
    return queryResult.map((e) => EstablishmentType.fromJson(e)).toList();
  }

  //Insert EstablishmentType Data
  Future<int> insertEstablishmentType(EstablishmentType establishmentType) async {
    final Database db = await initializeDB();
    final id = await db.insert('EstablishmentType', establishmentType.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  //Get OwnershipType Data
  Future<List<OwnershipType>> getOwnershipTypeItems() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
    await db.query('OwnershipType');
    return queryResult.map((e) => OwnershipType.fromJson(e)).toList();
  }

  //Insert OwnershipType Data
  Future<int> insertOwnershipType(OwnershipType ownershipType) async {
    final Database db = await initializeDB();
    final id = await db.insert('OwnershipType', ownershipType.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

}
