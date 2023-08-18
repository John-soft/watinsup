import 'package:flutter/material.dart';
import 'package:watinsup/common/widgets/error_screen.dart';
import 'package:watinsup/features/auth/screens/login_screen.dart';
import 'package:watinsup/features/auth/screens/otp_Screen.dart';
import 'package:watinsup/features/auth/screens/user_information_screen.dart';
import 'package:watinsup/features/select_contact/screens/select_contacts_screen.dart';
import 'package:watinsup/features/chat/screen/mobile_chat_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final String verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verficationId: verificationId,
        ),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );

    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
        ),
      );

    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactsScreen(),
      );

    default:
      return MaterialPageRoute(
          builder: (context) =>
              const ErrorScreen(error: "This page doesn't exist"));
  }
}
