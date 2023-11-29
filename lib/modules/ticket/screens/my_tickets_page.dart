import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/modules/auth/sreens/sign_in_required.dart';
import 'package:demo/modules/ticket/ticket_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyTicketScreen extends StatefulWidget {
  const MyTicketScreen({Key? key}) : super(key: key);

  @override
  State<MyTicketScreen> createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final _db = FirebaseFirestore.instance;
  List<String> idTransitions = [];

  Future<List<String>> getMyTicketData() async {
    List<String> tickets = [];

    if (user != null) {
      String userId = user!.uid;

      try {
        QuerySnapshot querySnapshot = await _db
            .collection('Tickets')
            .where('idAccount', isEqualTo: userId)
            .get();

        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          var ticketData = doc.data() as Map<String, dynamic>;
          var idTransition = ticketData['idTransition'];
          if (idTransition != null) {
            idTransitions.add(idTransition);
            tickets.add(idTransition);
          } else {
            print("Field 'idTransition' is null or not present.");
          }
        }
      } catch (error) {
        print("Error querying Firestore: $error");
      }
    }

    return tickets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "My tickets",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: false,
        backgroundColor: const Color(0xFFd6c3fb),
      ),
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
          if (user != null)
            FutureBuilder<List<String>>(
              future: getMyTicketData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("No data available");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String idTransition = snapshot.data![index];
                      return TicketView(idTransition: idTransition);
                    },
                  );
                }
              },
            )
          else
            const SignInRequiredScreen()
        ],
      ),
    );
  }
}
