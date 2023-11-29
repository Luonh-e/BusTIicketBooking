import 'package:demo/models/user_model.dart';
import 'package:demo/modules/auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:demo/modules/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            onPressed: null,
          ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 50, 40, 10),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: TextField(
                    controller: _fullnameController,
                    decoration: const InputDecoration(
                        labelText: "FULL NAME",
                        labelStyle:
                            TextStyle(color: Color(0xff888888), fontSize: 15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                        labelText: "PHONE NUMBER",
                        labelStyle:
                            TextStyle(color: Color(0xff888888), fontSize: 15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: "USERNAME",
                        labelStyle:
                            TextStyle(color: Color(0xff888888), fontSize: 15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: <Widget>[
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: "PASSWORD",
                            labelStyle: TextStyle(
                                color: Color(0xff888888), fontSize: 15)),
                      ),
                      const Text("show",
                          style: TextStyle(
                              color: Color.fromARGB(255, 56, 13, 212),
                              fontSize: 14,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: <Widget>[
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: "PASSWORD AGAIN",
                            labelStyle: TextStyle(
                                color: Color(0xff888888), fontSize: 15)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Color(0xff8f70ee)),
                      ),
                      onPressed: () {
                        _signUp();
                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Already have account. Sign in now",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  void _signUp() async {
    UserModel newUser = UserModel(
        fullName: _fullnameController.text,
        phoneNo: _phoneController.text,
        email: _emailController.text,
        password: _passwordController.text);
    User? user = await _auth.signUpUser(newUser);
    if (user != null) {
      print("Thông tin $user");
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomBar(),
          ),
        );
      }
    } else {
      print('Sign up has some error');
    }
  }
}
