import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/modules/ticket/screens/my_tickets_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class selectSeatScreen extends StatefulWidget {
  final Map<String, dynamic> selectedTicketData;
  const selectSeatScreen({super.key, required this.selectedTicketData});

  @override
  State<selectSeatScreen> createState() => _selectSeatScreenState();
}

class _selectSeatScreenState extends State<selectSeatScreen> {
  final _db = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  List<bool> isSeatSelected = List.generate(44, (index) => false);
  List<int> seatBooked = [1, 5, 13, 15, 17, 18, 20, 24];
  List<int> selectedSeats = [];
  String yourSeats = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          onPressed: null,
        ),
        backgroundColor: const Color(0xFFd6c3fb),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Text(
            widget.selectedTicketData['route'],
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        centerTitle: false,
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
          Positioned(
            left: 0,
            right: 0,
            top: 10,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 20),
              color: const Color(0xFFd6c3fb),
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
                              image:
                                  AssetImage("assets/images/limousine 2.jpeg"),
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Limousine giường nằm \n 40 chỗ",
                              textAlign: TextAlign.end,
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white)),
                          Text(widget.selectedTicketData['ticket'].busNumber,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            margin: const EdgeInsets.fromLTRB(30, 120, 30, 150),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
              ),
              itemCount: 44,
              itemBuilder: (context, index) {
                if (index < 4) {
                  return Center(
                    child: Text(
                      String.fromCharCode(
                          index + 65), // Số hiển thị trên ghế ngồi
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (isSeatBooked(index - 3, seatBooked)) {
                  return InkWell(
                    onTap: () {
                      print('Chọn ghế số: ${index - 3}');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/booked_img.png"),
                        ),
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSeatSelected[index] = !isSeatSelected[index];
                      });
                      if (selectedSeats.contains(index - 3)) {
                        selectedSeats.remove(index - 3);
                      } else {
                        selectedSeats.add(index - 3);
                      }
                      yourSeats = getSeatName(selectedSeats);
                      print('Chọn ghế số: $yourSeats');
                    },
                    child: SeatWidget(
                      seatNumber: index + 1,
                      isSelected: isSeatSelected[index],
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Your seats: $yourSeats'),
                  ),
                  Container(
                    margin: const EdgeInsets.all(30),
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Color(0xff8f70ee)),
                      ),
                      onPressed: () {
                        ticketComplete();
                      },
                      child: const Text(
                        "CONTINUTE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ticketComplete() {
    String priceTicketString =
        (widget.selectedTicketData['ticket'].priceTicket).replaceAll('VND', '');
    double priceTicket = double.parse(priceTicketString);
    String priceTotal = (selectedSeats.length * priceTicket).toString();
    priceTotal = priceTotal.replaceAll('.0', '');
    priceTotal += '.000VND';
    Map<String, dynamic> data = {
      "idAccount": user?.uid,
      "idTransition": widget.selectedTicketData['ticket'].id,
      "seatSelected": selectedSeats,
      "priceTotal": priceTotal,
    };

    _db.collection('Tickets').add(data);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyTicketScreen(),
        ));
  }
}

bool isSeatBooked(int index, List<int> sequence) {
  return sequence.contains(index);
}

String getSeatName(List<int> seatList) {
  // Ánh xạ index của ghế vào chuỗi theo quy tắc A1, B1, C1, D1, A2, ...
  List<String> result = [];

  for (int seatNumber in seatList) {
    int row = ((seatNumber - 1) ~/ 4) + 1;
    String column =
        String.fromCharCode(((seatNumber - 1) % 4) + 'A'.codeUnitAt(0));
    result.add('$row$column');
  }

  // Nối các phần tử thành một chuỗi, phân tách bằng dấu phẩy
  return result.join(', ');
}

class SeatWidget extends StatelessWidget {
  final int seatNumber;
  final bool isSelected;

  const SeatWidget(
      {super.key, required this.seatNumber, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isSelected
              ? const AssetImage("assets/images/your_seat_img.png")
              : const AssetImage("assets/images/available_img.png"),
        ),
      ),
    );
  }
}
