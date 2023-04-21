import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:labour_inspection/services/labour_inspection_api.dart';
import 'dart:convert';

import '../models/establishment.dart';

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

  late int _currentPage;

  final List<String> _ownershipTypes = [
    'Sole Proprietorship',
    'Partnership',
    'Limited Liability Company',
    'Corporation',
    'Non-Profit Organization'
  ];

  final List<String> _establishmentTypes = [
    'Hotel',
    'Restaurant',
    'Retail Store',
    'Service Provider',
    'Manufacturer'
  ];

  final List<String> _accommodationTypes = [
    'Hotel',
    'Motel',
    'Inn',
    'Resort',
    'Vacation Rental'
  ];

  final List<String> _industries = [
    'Technology',
    'Finance',
    'Healthcare',
    'Education',
    'Manufacturing',
    'Retail',
    'Hospitality'
  ];

  final List<String> _regions = [
    'Region 1',
    'Region 2',
    'Region 3',
    'Region 4',
    'Region 5'
  ];

  final List<String> _districts = [
    'District 1',
    'District 2',
    'District 3',
    'District 4',
    'District 5'
  ];

  @override
  void initState() {
    super.initState();
    _establishment = Establishment();
    _currentPage = 0;
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
    LabourInspectionApi.createEstablishment(_establishment);
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();

    //   final response = await http.post(
    //     Uri.parse('https://localhost/api/establishments'),
    //     headers: {
    //       'Content-Type': 'application/json',
    //     },
    //     body: jsonEncode(_establishment.toJson()),
    //   );

    //   if (response.statusCode == 201) {
    //     Navigator.pop(context);
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Failed to create establishment')),
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Establishment'),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (_currentPage != 0)
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _goToPreviousPage,
                ),
              if (_currentPage != 2) const SizedBox(),
              TextButton(
                child: Text('Next'),
                onPressed: _goToNextPage,
              ),
              if (_currentPage == 2)
                ElevatedButton(
                  child: Text('Submit'),
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
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
                                labelText: 'Ownership Type',
                              ),
                              items: _ownershipTypes
                                  .map(
                                    (ownershipType) => DropdownMenuItem(
                                      child: Text(ownershipType),
                                      value: _ownershipTypes
                                              .indexOf(ownershipType) +
                                          1,
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
                              decoration: InputDecoration(
                                labelText: 'Establishment Type',
                              ),
                              items: _establishmentTypes
                                  .map(
                                    (establishmentType) => DropdownMenuItem(
                                      child: Text(establishmentType),
                                      value: _establishmentTypes
                                              .indexOf(establishmentType) +
                                          1,
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
                              value: _establishment.accomodationTypeId,
                              decoration: InputDecoration(
                                labelText: 'Accommodation Type',
                              ),
                              items: _accommodationTypes
                                  .map(
                                    (accommodationType) => DropdownMenuItem(
                                      child: Text(accommodationType),
                                      value: _accommodationTypes
                                              .indexOf(accommodationType) +
                                          1,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _establishment.accomodationTypeId =
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
                              decoration: InputDecoration(
                                labelText: 'Region',
                              ),
                              items: _regions
                                  .map(
                                    (region) => DropdownMenuItem(
                                      child: Text(region),
                                      value: _regions.indexOf(region) + 1,
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
                              decoration: InputDecoration(
                                labelText: 'District',
                              ),
                              items: _districts
                                  .map(
                                    (district) => DropdownMenuItem(
                                      child: Text(district),
                                      value: _districts.indexOf(district) + 1,
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
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
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
                              decoration: InputDecoration(
                                labelText: 'Industry',
                              ),
                              items: _industries
                                  .map(
                                    (industry) => DropdownMenuItem(
                                      child: Text(industry),
                                      value: _industries.indexOf(industry) + 1,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _establishment.industryId = value as int?;
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
                              decoration: InputDecoration(
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
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _registrationPlaceController,
                              decoration: InputDecoration(
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
                            SizedBox(height: 16),
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
                            SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: _submitForm,
                              child: Text('Submit'),
                            ),
                          ]
                        ])))));
  }
}
