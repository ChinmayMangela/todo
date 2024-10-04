import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/authentication/presentation/screens/email_verification_page.dart';
import 'package:todo/features/authentication/presentation/screens/login_or_signup.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if(snapshot.hasData) {
        return const EmailVerificationPage();
      } else {
        return const LoginOrSignup();
      }
    });
  }
}
