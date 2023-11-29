import 'package:demo/modules/auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:demo/modules/auth/sreens/sign_up_page.dart';
import 'package:demo/modules/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
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
                  padding: EdgeInsets.fromLTRB(40, 100, 40, 10),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 50, 40, 10),
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
                      onPressed: _signIn,
                      child: const Text(
                        "SIGN IN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                  child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              // Xử lý khi nhấp vào "Sign up"
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()), // Đổi SignUpScreen() bằng màn hình đăng ký thực tế của bạn
                              );
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: 'New user? ',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Text(
                            "Forget password?",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      )),
                )
              ],
            )
          ],
        ));
  }

  void _signIn() async {
    String username = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(username, password);

    if (user != null) {
      print(user);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomBar(),
          ),
        );
      }
    } else {
      print('Sign in has some error');
    }
  }
}
