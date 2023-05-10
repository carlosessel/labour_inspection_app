import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:labour_inspection/services/labour_inspection_api.dart';
import 'dart:convert';

import '../models/accommodation_type.dart';
import '../models/district.dart';
import '../models/establishment.dart';
import '../models/establishment_Type.dart';
import '../models/industry.dart';
import '../models/ownership_type.dart';
import '../models/region.dart';
import '../services/sqlite_service.dart';

class CreateEstablishmentPage extends StatefulWidget {
  @override
  _CreateEstablishmentPageState createState() =>
      _CreateEstablishmentPageState();
}

class _CreateEstablishmentPageState extends State<CreateEstablishmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime? _selectedDateTime;

  final TextEditingController _establishmentNameController =
      TextEditingController();

  final TextEditingController _localityController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _mainActivityController = TextEditingController();

  final TextEditingController _businessRegistrationDateController =
      TextEditingController();

  final TextEditingController _registrationPlaceController =
      TextEditingController();

  final TextEditingController _businessCommencementDateController =
      TextEditingController();

  late Establishment _establishment;
  
  final SqliteService _sqliteService = SqliteService();

  List<District> districts = [];
  List<Region> regions = [];
  List<Industry> industries = [];
  List<EstablishmentType> establishmentTypes = [];
  List<AccommodationType> accommodationTypes = [];
  List<OwnershipType> ownershipTypes = [];

  late int _currentPage;

  // final List<String> _ownershipTypes = [
  //   'Sole Proprietorship',
  //   'Partnership',
  //   'Limited Liability Company',
  //   'Corporation',
  //   'Non-Profit Organization'
  // ];
  //
  // final List<String> _establishmentTypes = [
  //   'Hotel',
  //   'Restaurant',
  //   'Retail Store',
  //   'Service Provider',
  //   'Manufacturer'
  // ];
  //
  // final List<String> _accommodationTypes = [
  //   'Hotel',
  //   'Motel',
  //   'Inn',
  //   'Resort',
  //   'Vacation Rental'
  // ];
  //
  // final List<String> _industries = [
  //   'Technology',
  //   'Finance',
  //   'Healthcare',
  //   'Education',
  //   'Manufacturing',
  //   'Retail',
  //   'Hospitality'
  // ];
  //
  // final List<String> _regions = [
  //   'Region 1',
  //   'Region 2',
  //   'Region 3',
  //   'Region 4',
  //   'Region 5'
  // ];

  // final List<String> _districts = [
  //   'District 1',
  //   'District 2',
  //   'District 3',
  //   'District 4',
  //   'District 5'
  // ];

  @override
  void initState() {
    super.initState();
    _establishment = Establishment();
    _currentPage = 0;
    _getDistrictsData();
    _getRegionsData();
    _getIndustryData();
    _getAccommodationTypeData();
    _getEstablishmentTypeData();
    _getOwnershipTypeData();
  }

  //Get District Data
  Future<void> _getDistrictsData() async{

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      Future<List<District>> _districts = LabourInspectionApi.getDistricts();
      setState(() async {
        districts = await _districts;
      });

      _districts.then((value) => value.forEach((element) {
        _sqliteService.insertDistrict(element);
      }));

    }
    else
    {
      _sqliteService.initializeDB().whenComplete(() async {
        final data = await _sqliteService.getDistrictItems();
        setState(() {
          districts = data;
        });
      });
    }
    setState(() {});
  }

  //Get Region Data
  Future<void> _getRegionsData() async{

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      Future<List<Region>> _regions = LabourInspectionApi.getRegions();
      setState(() async {
        regions = await _regions;
      });

      _regions.then((value) => value.forEach((element) {
        _sqliteService.insertRegion(element);
      }));

    }
    else
    {
      _sqliteService.initializeDB().whenComplete(() async {
        final data = await _sqliteService.getRegionItems();
        setState(() {
          regions = data;
        });
      });
    }
    setState(() {});
  }

  //Get Industry Data
  Future<void> _getIndustryData() async{

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      Future<List<Industry>> _industries = LabourInspectionApi.getIndustries();
      setState(() async {
        industries = await _industries;
      });

      _industries.then((value) => value.forEach((element) {
        _sqliteService.insertIndustry(element);
      }));

    }
    else
    {
      _sqliteService.initializeDB().whenComplete(() async {
        final data = await _sqliteService.getIndustryItems();
        setState(() {
          industries = data;
        });
      });
    }
    setState(() {});
  }

  //Get AccommodationType Data
  Future<void> _getAccommodationTypeData() async{

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      Future<List<AccommodationType>> _accommodationTypes = LabourInspectionApi.getAccommodationTypes();
      setState(() async {
        accommodationTypes = await _accommodationTypes;
      });

      _accommodationTypes.then((value) => value.forEach((element) {
        _sqliteService.insertAccommodationType(element);
      }));

    }
    else
    {
      _sqliteService.initializeDB().whenComplete(() async {
        final data = await _sqliteService.getAccommodationTypeItems();
        setState(() {
          accommodationTypes = data;
        });
      });
    }
    setState(() {});
  }

  //Get EstablishmentType Data
  Future<void> _getEstablishmentTypeData() async{

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      Future<List<EstablishmentType>> _establishmentTypes = LabourInspectionApi.getEstablishmentTypes();
      setState(() async {
        establishmentTypes = await _establishmentTypes;
      });

      _establishmentTypes.then((value) => value.forEach((element) {
        _sqliteService.insertEstablishmentType(element);
      }));

    }
    else
    {
      _sqliteService.initializeDB().whenComplete(() async {
        final data = await _sqliteService.getEstablishmentTypeItems();
        setState(() {
          establishmentTypes = data;
        });
      });
    }
    setState(() {});
  }

  //Get OwnershipType Data
  Future<void> _getOwnershipTypeData() async{

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

      Future<List<OwnershipType>> _ownershipTypes = LabourInspectionApi.getOwnershipTypes();
      setState(() async {
        ownershipTypes = await _ownershipTypes;
      });

      _ownershipTypes.then((value) => value.forEach((element) {
        _sqliteService.insertOwnershipType(element);
      }));

    }
    else
    {
      _sqliteService.initializeDB().whenComplete(() async {
        final data = await _sqliteService.getOwnershipTypeItems();
        setState(() {
          ownershipTypes = data;
        });
      });
    }
    setState(() {});
  }

  

  void _goToNextPage() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _currentPage++;
      });
    }
  }

  void _goToPreviousPage() {
    setState(() {
      _currentPage--;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final connectivityResult = await (Connectivity().checkConnectivity());

      _sqliteService.insertEstablishment(_establishment);

      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
        final response = await http.post(
          Uri.parse('https://localhost:7283/api/establishments'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(_establishment.toJson()),
        );

        if (response.statusCode == 201) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create establishment')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Establishment'),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (_currentPage != 0)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _goToPreviousPage,
                ),
              if (_currentPage != 2) const SizedBox(),
              TextButton(
                child: const Text('Next'),
                onPressed: _goToNextPage,
              ),
              if (_currentPage == 2)
                ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: _submitForm,
                ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (_currentPage == 0) ...[
                            Text(
                              'Basic Information',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            TextFormField(
                              controller: _establishmentNameController,
                              decoration: const InputDecoration(
                                labelText: 'Establishment Name',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _establishment.establishmentName = value!;
                              },
                            ),
                            DropdownButtonFormField(
                              value: _establishment.ownerShipTypeId,
                              decoration: const InputDecoration(
                                labelText: 'Ownership Type',
                              ),
                              items: ownershipTypes
                                  .map(
                                    (ownershipType) => DropdownMenuItem(
                                      value: ownershipType.ownershipTypeId,
                                      child: Text(ownershipType.ownershipTypeName!),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _establishment.ownerShipTypeId =
                                      value as int?;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select an ownership type';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField(
                              value: _establishment.establishmentTypeId,
                              decoration: const InputDecoration(
                                labelText: 'Establishment Type',
                              ),
                              items: establishmentTypes
                                  .map(
                                    (establishmentType) => DropdownMenuItem(
                                      value: establishmentType.establishmentTypeId,
                                      child: Text(establishmentType.establishmentTypeName!),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _establishment.establishmentTypeId =
                                      value as int?;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select an establishment type';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField(
                              value: _establishment.accommodationTypeId,
                              decoration: const InputDecoration(
                                labelText: 'Accommodation Type',
                              ),
                              items: accommodationTypes
                                  .map(
                                    (accommodationType) => DropdownMenuItem(
                                      value: accommodationType.accommodationTypeId,
                                      child: Text(accommodationType.accommodationTypeName!),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _establishment.accommodationTypeId =
                                      value as int?;
                                });
                              },
                            ),
                          ],
                          if (_currentPage == 1) ...[
                            Text(
                              'Location Information',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            DropdownButtonFormField(
                              value: _establishment.regionId,
                              decoration: const InputDecoration(
                                labelText: 'Region',
                              ),
                              items: regions
                                  .map(
                                    (region) => DropdownMenuItem(
                                      value: region.regionId,
                                      child: Text(region.regionName!),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _establishment.regionId = value as int?;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a region';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField(
                              value: _establishment.districtId,
                              decoration: const InputDecoration(
                                labelText: 'District',
                              ),
                              items: districts
                                  .map(
                                    (district) => DropdownMenuItem(
                                      child: Text(district.districtName!),
                                      value: district.districtId
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _establishment.districtId = value as int?;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a district';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _localityController,
                              decoration: const InputDecoration(
                                labelText: 'Locality',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a locality';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _establishment.locality = value!;
                              },
                            ),
                            TextFormField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                labelText: 'Address',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter an address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _establishment.address = value!;
                              },
                            ),
                          ],
                          if (_currentPage == 2) ...[
                            Text(
                              'Contact Information',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            TextFormField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a phone number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _establishment.phoneNumber = value!;
                              },
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter an email address';
                                } else if (!EmailValidator.validate(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _establishment.email = value!;
                              },
                            ),
                            DropdownButtonFormField(
                              value: _establishment.industryId,
                              decoration: const InputDecoration(
                                labelText: 'Industry',
                              ),
                              items: industries
                                  .map(
                                    (industry) => DropdownMenuItem(
                                      value: industry.industryId,
                                      child: Text(industry.industryName!),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _establishment.industryId = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select an industry';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _mainActivityController,
                              decoration: const InputDecoration(
                                labelText: 'Main Activity Undertaken',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a main activity';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(
                                  () {
                                    _establishment.mainActivityUndertaken =
                                        value!;
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 16),

                            DateTimeField(
                              decoration: const InputDecoration(
                                  labelText: 'Business Registration Date'),
                              format: format,
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  _selectedDateTime = date;
                                  return _selectedDateTime!;
                                } else {
                                  return currentValue;
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please enter business registration date';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null) {
                                  _establishment.businessRegistrationDate =
                                      value;
                                }
                              },
                            ),
                            // TextFormField(
                            //   controller: _businessRegistrationDateController,
                            //   decoration: InputDecoration(
                            //     labelText: 'Business Registration Date',
                            //   ),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Please enter a business registration date';
                            //     }
                            //     return null;
                            //   },
                            //   onSaved: (value) {
                            //     _establishment.businessRegistrationDate =
                            //         value!;
                            //   },
                            // ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _registrationPlaceController,
                              decoration: const InputDecoration(
                                labelText: 'Registration Place',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a registration place';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _establishment.registrationPlace = value!;
                              },
                            ),
                            const SizedBox(height: 16),
                            DateTimeField(
                              decoration: const InputDecoration(
                                  labelText: 'Business Commencement Date'),
                              format: format,
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (date != null) {
                                  _selectedDateTime = date;
                                  print(_selectedDateTime
                                      ?.toIso8601String()
                                      .replaceAll('.000', ''));
                                  return _selectedDateTime!;
                                } else {
                                  return currentValue;
                                }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please enter business commmencement date';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null) {
                                  _establishment.businessCommencementDate =
                                      value;
                                }
                              },
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('Submit'),
                            ),
                          ]
                        ]
                    )
                )
            )
        )
    );
  }
}
