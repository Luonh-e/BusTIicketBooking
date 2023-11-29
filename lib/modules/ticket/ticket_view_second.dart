import 'package:demo/config/themes/app_layout.dart';
import 'package:demo/models/ticket_model.dart';
import 'package:flutter/material.dart';

class TicketViewSecond extends StatelessWidget {
  final TicketModel ticket;
  const TicketViewSecond({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return SizedBox(
      width: size.width * 0.95,
      height: 300,
      child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(children: [
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
                      Text(ticket.departureDate,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const Spacer(),
                      Text(ticket.priceTicket,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ),
                  Row(
                    children: [
                      Text(ticket.departureTime,
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
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 50),
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
                          Text(ticket.busNumber,
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
          ])),
    );
  }
}
