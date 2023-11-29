import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Notifications",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
            Center(
              child: Container(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        FluentSystemIcons
                            .ic_fluent_channel_notifications_filled,
                        color: Colors.blue,
                        size: 110),
                    Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 15),
                      child: Text(
                        "You have no notifications yet",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "When there's any update on tickets status,\n you'll see this here",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
