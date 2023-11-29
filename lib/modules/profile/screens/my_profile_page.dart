import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/config/themes/app_layout.dart';
import 'package:demo/models/user_model.dart';
import 'package:demo/modules/auth/sreens/sign_in_required.dart';
import 'package:demo/modules/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late DocumentSnapshot documentSnapshot;
  UserModel userModel = const UserModel(email: '', fullName: '', phoneNo: '');
  late Future<UserModel> userData;

  @override
  void initState() {
    super.initState();
    userData = getUserData();
  }

  Future<UserModel> getUserData() async {
    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user?.uid)
            .get();

        return UserModel(
          fullName: documentSnapshot['FullName'],
          phoneNo: documentSnapshot['Phone'],
          email: documentSnapshot['Email'],
        );
      } catch (e) {
        print("Error fetching user data: $e");
        rethrow; // Rethrow the exception to mark the Future as completed with an error
      }
    }
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "My profile",
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
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
            FutureBuilder<UserModel>(
                future: userData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    UserModel userModel = snapshot.data!;
                    return ListView(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height / 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: const AssetImage(
                                      'assets/images/profile_img.jpeg'),
                                  radius: size.height / 10,
                                ),
                                SizedBox(
                                  height: size.height / 30,
                                ),
                                Text(
                                  userModel.fullName.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: size.height / 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                              FluentSystemIcons
                                                  .ic_fluent_mail_all_filled,
                                              color: Colors.blue,
                                              size: 40),
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Text(
                                              userModel.email.toString(),
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                              FluentSystemIcons
                                                  .ic_fluent_phone_filled,
                                              color: Colors.blue,
                                              size: 40),
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Text(
                                              userModel.phoneNo,
                                              style:
                                                  const TextStyle(fontSize: 17),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                              FluentSystemIcons
                                                  .ic_fluent_help_circle_filled,
                                              color: Colors.blue,
                                              size: 40),
                                          Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Text(
                                              "Help Center",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          )
                                        ],
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                              FluentSystemIcons
                                                  .ic_fluent_settings_filled,
                                              color: Colors.blue,
                                              size: 40),
                                          Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Text(
                                              "Settings",
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          signOutUser();
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                                FluentSystemIcons
                                                    .ic_fluent_sign_out_filled,
                                                color: Colors.blue,
                                                size: 40),
                                            Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Text(
                                                "Log out",
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                })
          else
            const SignInRequiredScreen()
        ],
      ),
    );
  }

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomBar()),
      );
    }
  }
}
