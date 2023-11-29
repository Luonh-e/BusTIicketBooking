import 'package:demo/modules/ticket/screens/select_seat_page.dart';
import 'package:demo/modules/ticket/ticket_view_second.dart';
import 'package:flutter/material.dart';

class selectTicketScreen extends StatefulWidget {
  final Map<String, dynamic> screenData;
  const selectTicketScreen({super.key, required this.screenData});

  @override
  State<selectTicketScreen> createState() => _selectTicketScreenState();
}

class _selectTicketScreenState extends State<selectTicketScreen> {
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
            widget.screenData['route'],
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
          ListView.builder(
            itemCount: widget.screenData['tickets'].length,
            itemBuilder: (context, index) {
              final ticket = widget.screenData['tickets'][index];
              return InkWell(
                onTap: () {
                  goToSelectSeat(ticket);
                },
                child: TicketViewSecond(ticket: ticket),
              );
            },
          ),
        ],
      ),
    );
  }

  void goToSelectSeat(ticket) {
    final Map<String, dynamic> selectedTicketData = {
      'route': widget.screenData['route'],
      'ticket': ticket,
    };
    print(selectedTicketData);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              selectSeatScreen(selectedTicketData: selectedTicketData)),
    );
  }
}
