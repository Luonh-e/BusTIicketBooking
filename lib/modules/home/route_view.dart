import 'package:demo/config/themes/app_layout.dart';
import 'package:flutter/material.dart';

class RouteView extends StatelessWidget {
  final Map<String, dynamic> route;
  const RouteView({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Container(
      width: size.width * 0.4,
      height: 260,
      margin: const EdgeInsets.fromLTRB(30, 0, 0, 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              spreadRadius: 2,
            )
          ]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/${route['image']}"),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        Text("${route['route']}",
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade800,
            ))
      ]),
    );
  }
}
