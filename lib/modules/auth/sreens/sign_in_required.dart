import 'package:demo/modules/auth/sreens/sign_in_page.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class SignInRequiredScreen extends StatefulWidget {
  const SignInRequiredScreen({super.key});

  @override
  State<SignInRequiredScreen> createState() => _SignInRequiredScreenState();
}

class _SignInRequiredScreenState extends State<SignInRequiredScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(FluentSystemIcons.ic_fluent_person_board_filled,
              color: Colors.blue, size: 110),
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 15),
            child: Text(
              "Signin required",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text("Sign in to see more infomation"),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 15, 40, 10),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Color(0xff8f70ee)),
                ),
                onPressed: () {
                  onSignInClicked(context);
                },
                child: const Text(
                  "SIGN IN",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void onSignInClicked(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignInScreen()),
  );
}
