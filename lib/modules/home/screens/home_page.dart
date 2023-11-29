import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/ticket_model.dart';
import 'package:demo/modules/auth/sreens/sign_in_page.dart';
import 'package:demo/modules/home/route_view.dart';
import 'package:demo/modules/home/screens/city_select_View.dart';
import 'package:demo/modules/ticket/screens/select_ticket_page.dart';
import 'package:demo/utils/app_info_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String startPoint = '';
  String endPoint = '';
  String startPointText = "Start point";
  String endPointText = "Where to?";
  dynamic departureDate = 'Departure date';
  Map<String, String> items = {};

  Future<void> getCity() async {
    CollectionReference cities = _db.collection('City');

    QuerySnapshot diadiemSnapshot = await cities.get();

    for (var doc in diadiemSnapshot.docs) {
      items[doc.id] = doc['nameCity'];
    }
  }

  void _showCityStartSelect() async {
    final String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CitySelectView(items: items);
      },
    );

    if (result != null) {
      setState(() {
        startPoint = result;
        startPointText = items[result].toString();
      });
    }
  }

  void _showCityEndSelect() async {
    final String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CitySelectView(items: items);
      },
    );

    if (result != null) {
      setState(() {
        endPoint = result;
        endPointText = items[result].toString();
      });
    }
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      setState(() {
        departureDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getCity();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset("assets/images/bus.png")),
                          if (user == null)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()),
                                );
                              },
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          else
                            const Text(
                              "Welcome",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                          "Guarantee 150% refund if transport\nservice is not provided"),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(40, 25, 40, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[300]!)),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    _showCityStartSelect();
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.circle_outlined,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                        height: 50,
                                      ),
                                      Text(startPointText),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[300]!)),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    _showCityEndSelect();
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        FluentSystemIcons
                                            .ic_fluent_location_filled,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                        height: 60,
                                      ),
                                      Text(endPointText),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(),
                                child: InkWell(
                                  onTap: () {
                                    _showDatePicker();
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        FluentSystemIcons
                                            .ic_fluent_calendar_add_filled,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                        height: 50,
                                      ),
                                      Text(departureDate),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color(0xff8f70ee)),
                          ),
                          onPressed: () {
                            onSearchTickets(context);
                          },
                          child: const Text(
                            "SEARCH TICKETS",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Text(
                        "Popular bus routes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: routeList
                      .map((route) => RouteView(route: route))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onSearchTickets(BuildContext context) {
    _db
        .collection("Routes")
        .where("startPoint", isEqualTo: startPoint)
        .where("endPoint", isEqualTo: endPoint)
        .where("departureDate", isEqualTo: departureDate)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        List<TicketModel> tickets = querySnapshot.docs.map((doc) {
          return TicketModel(
            id: doc.id,
            busNumber: doc['busNumber'],
            departureDate: doc['departureDate'],
            departureTime: doc['departureTime'],
            endPoint: doc['endPoint'],
            priceTicket: doc['priceTicket'],
            startPoint: doc['startPoint'],
          );
        }).toList();
        final String route = '$startPointText - $endPointText';
        final Map<String, dynamic> screenData = {
          'route': route,
          'tickets': tickets,
        };
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => selectTicketScreen(screenData: screenData)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No tickets found for the selected criteria.'),
          ),
        );
      }
    }).catchError((error) {
      print("Error searching tickets: $error");
      // Handle errors, such as Firebase connection issues.
      // You can display an error message to the user.
    });
  }
}
