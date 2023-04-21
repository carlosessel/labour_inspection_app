import 'package:flutter/material.dart';
import 'package:labour_inspection/screens/add_establishment_page.dart';
import 'package:labour_inspection/screens/paginated_create_page.dart';
import 'package:labour_inspection/screens/updated_create_page.dart';
import 'package:labour_inspection/services/labour_inspection_api.dart';

import '../models/establishment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Establishment>> _futureEstablishments;

  @override
  void initState() {
    super.initState();
    setState(() {
      _futureEstablishments = LabourInspectionApi.getEstablishments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),

          //Menu and avatar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: const AssetImage('assets/images/avatar.jpg'),
                  child: Container(
                      decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/avatar.jpg'),
                      fit: BoxFit.fill,
                    ),
                  )),
                ),
              ],
            ),
          ),

          //search
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: Row(
              children: const [
                Icon(Icons.search),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.filter_list),
              ],
            ),
          ),

          //Card on top of list
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage('assets/images/building5.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Labour Inspection?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 5.0),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //view all
          GestureDetector(
            onTap: () => {},
            child: Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'View All',
                    style: TextStyle(color: Colors.blue),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),

          //list
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 226, 222, 222),
              child: FutureBuilder<List<Establishment>>(
                future: _futureEstablishments,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Establishment> establishments = snapshot.data!;
                    return ListView.builder(
                      itemCount:
                          establishments == null ? 0 : establishments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemTile(
                            establishmentName:
                                establishments[index].establishmentName,
                            establishmentAddress: establishments[index].address,
                            establishmentPhoneNumber:
                                establishments[index].phoneNumber,
                            establishmentEmail: establishments[index].email);
                        // ListTile(
                        //     title: Text(establishments[index].establishmentName));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: const Center(child: CircularProgressIndicator()));
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateEstablishmentPage()),
        ),
        child: const CircleAvatar(
            radius: 30,
            child: Center(
              child: Icon(Icons.add),
            )),
      ),
    );
  }
}

//List Tile Widget
class ItemTile extends StatelessWidget {
  final String? establishmentName;
  final String? establishmentAddress;
  final String? establishmentPhoneNumber;
  final String? establishmentEmail;

  const ItemTile(
      {required this.establishmentName,
      required this.establishmentAddress,
      required this.establishmentPhoneNumber,
      required this.establishmentEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          //shadowColor: const Color(0xFFD0D0D0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage('assets/images/building4.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        establishmentName!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$establishmentAddress | $establishmentPhoneNumber',
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      Text(
                        establishmentEmail!,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => MyHomePage(
                            //             title: 'Labour Inspection',
                            //           )),
                            // ),
                            child: const Icon(
                              Icons.create_new_folder_outlined,
                              size: 30.0,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.downloading_outlined,
                            size: 30.0,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.more_outlined,
                            size: 30.0,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
