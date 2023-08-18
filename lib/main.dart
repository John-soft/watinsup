import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watinsup/colors.dart';
import 'package:watinsup/common/widgets/error_screen.dart';
import 'package:watinsup/common/widgets/loader.dart';
import 'package:watinsup/features/auth/controller/auth_controller.dart';
import 'package:watinsup/features/landing/screens/landing_screen.dart';
import 'package:watinsup/firebase_options.dart';
import 'package:watinsup/router.dart';
import 'package:watinsup/screens/mobile_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Watin Sup',
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          useMaterial3: false,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          )),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataProvider).when(
          data: (user) {
            if (user == null) {
              return const LandingScreen();
            }
            return const MobileLayoutScreen();
          },
          error: (err, trace) {
            return ErrorScreen(error: err.toString());
          },
          loading: () => const Loader()),
    );
  }
}
