// import 'package:flutter/material.dart';

// import '../models/establishment.dart';

// class CreateEstablishmentPage extends StatefulWidget {
//   @override
//   _CreateEstablishmentPageState createState() =>
//       _CreateEstablishmentPageState();
// }

// class _CreateEstablishmentPageState extends State<CreateEstablishmentPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _establishment = Establishment();
//   int _currentPage = 0;
//   final List<Widget> _pages = [
//     EstablishmentNamePage(),
//     ContactInfoPage(),
//   ];

//   void _goToNextPage() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _currentPage++;
//       });
//     }
//   }

//   void _goToPreviousPage() {
//     setState(() {
//       _currentPage--;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Establishment'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: _pages[_currentPage],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             if (_currentPage != 0)
//               IconButton(
//                 onPressed: _goToPreviousPage,
//                 icon: Icon(Icons.arrow_back),
//               ),
//             if (_currentPage != _pages.length - 1)
//               IconButton(
//                 onPressed: _goToNextPage,
//                 icon: Icon(Icons.arrow_forward),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EstablishmentNamePage extends StatefulWidget {
//   @override
//   _EstablishmentNamePageState createState() => _EstablishmentNamePageState();
// }

// class _EstablishmentNamePageState extends State<EstablishmentNamePage> {
//   final _establishment = Establishment();
//   final _establishmentNameController = TextEditingController();

//   @override
//   void dispose() {
//     _establishmentNameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           controller: _establishmentNameController,
//           decoration: InputDecoration(labelText: 'Establishment Name'),
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Establishment name is required';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _establishment.establishmentName = value!;
//           },
//         ),
//       ],
//     );
//   }
// }

// class ContactInfoPage extends StatefulWidget {
//   @override
//   _ContactInfoPageState createState() => _ContactInfoPageState();
// }

// class _ContactInfoPageState extends State<ContactInfoPage> {
//   final _establishment = Establishment();
//   final _phoneNumberController = TextEditingController();
//   final _emailController = TextEditingController();

//   @override
//   void dispose() {
//     _phoneNumberController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           controller: _phoneNumberController,
//           decoration: InputDecoration(labelText: 'Phone Number'),
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Phone number is required';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _establishment.phoneNumber = value!;
//           },
//         ),
//         TextFormField(
//           controller: _emailController,
//           decoration: InputDecoration(labelText: 'Email'),
//           validator: (value) {
//             if (value!.isEmpty) {
//               return 'Email is required';
//             }
//             return null;
//           },
//           onSaved: (value) {
//             _establishment.email = value!;
//           },
//         ),
//       ],
//     );
//   }
// }
