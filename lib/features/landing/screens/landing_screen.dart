import 'package:flutter/material.dart';
import 'package:watinsup/colors.dart';
import 'package:watinsup/common/widgets/custom_button.dart';
import 'package:watinsup/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/backgroundImage.png",
                    ),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Welcome to Watinsup',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: size.height / 9,
                ),
                Image.asset(
                  'assets/images/bg.png',
                  width: 340,
                  height: 340,
                  color: tabColor,
                ),
                SizedBox(
                  height: size.height / 9,
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Read our Privacy Policy. Tap "Agree and Continue" to accept the Terms of Service',
                    style: TextStyle(
                      color: greyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * 0.75,
                  child: CustomButton(
                    text: 'AGREE AND CONTINUE',
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
