import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/configs/theme/app_theme.dart';
import 'package:todo/features/authentication/presentation/screens/auth_gate.dart';
import 'package:todo/features/authentication/presentation/screens/login_or_signup.dart';
import 'package:todo/features/authentication/presentation/screens/login_page.dart';
import 'package:todo/features/task/presentation/providers/task_provider.dart';
import 'package:todo/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();
final messengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}
