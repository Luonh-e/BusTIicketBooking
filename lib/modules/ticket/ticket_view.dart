import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/config/themes/app_layout.dart';
import 'package:flutter/material.dart';

class TicketView extends StatefulWidget {
  final String idTransition;

  const TicketView({Key? key, required this.idTransition}) : super(key: key);

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  Future<Map<String, dynamic>> fetchData(String documentId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Routes')
          .doc(documentId)
          .get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        print('Document not found: $documentId');
      }
      return {};
    } catch (error) {
      print('Error fetching data: $error');
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is first created
    fetchData(widget.idTransition);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(widget.idTransition),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        } else if (snapshot.hasError) {
          // Handle the error
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Handle the case when the document doesn't exist or is empty
          return const Text('Document not found or is empty');
        }

        // Access data as a Map<String, dynamic>
        Map<String, dynamic> data = snapshot.data!;

        final size = AppLayout.getSize(context);
        return SizedBox(
          width: size.width * 0.95,
          height: 300,
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xfff1705e),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(21),
                          topRight: Radius.circular(21))),
                  padding: const EdgeInsets.fromLTRB(16, 16, 30, 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(data['departureDate'],
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          const Spacer(),
                          Text(data['priceTicket'],
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))
                        ],
                      ),
                      Row(
                        children: [
                          Text(data['departureTime'],
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xff8d69f4),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 10,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)))),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                (constraints.constrainWidth() / 15).floor(),
                                (index) => const SizedBox(
                                      width: 5,
                                      height: 1,
                                      child: DecoratedBox(
                                          decoration: BoxDecoration(
                                        color: Colors.white,
                                      )),
                                    )),
                          );
                        }),
                      )),
                      const SizedBox(
                        height: 20,
                        width: 10,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)))),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff8d69f4),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(21),
                          bottomRight: Radius.circular(21))),
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/limousine 2.jpeg"),
                                ),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text("Limousine giường nằm \n 40 chỗ",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white)),
                              Text(data['busNumber'],
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/qr_code.png"),
                                      ),
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
