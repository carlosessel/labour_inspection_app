// import 'package:flutter/material.dart';

// import '../models/establishment.dart';
// import '../services/labour_inspection_api.dart';

// class CreateEstablishmentPage extends StatefulWidget {
//   CreateEstablishmentPage({Key? key}) : super(key: key);

//   @override
//   _CreateEstablishmentPageState createState() =>
//       _CreateEstablishmentPageState();
// }

// class _CreateEstablishmentPageState extends State<CreateEstablishmentPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _establishment = Establishment();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Establishment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Establishment Name',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the establishment name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _establishment.establishmentName = value!;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Locality',
//                 ),
//                 onSaved: (value) {
//                   _establishment.locality = value!;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Address',
//                 ),
//                 onSaved: (value) {
//                   _establishment.address = value!;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Phone Number',
//                 ),
//                 keyboardType: TextInputType.phone,
//                 onSaved: (value) {
//                   _establishment.phoneNumber = value!;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     await LabourInspectionApi.createEstablishment(
//                         _establishment);
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
