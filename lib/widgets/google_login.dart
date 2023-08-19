import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoogleLogin extends StatefulWidget {
  const GoogleLogin({super.key});

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return IconButton(
              onPressed: () {
                GoogleAuthProvider googleProvider = GoogleAuthProvider();

                googleProvider.addScope(
                    'https://www.googleapis.com/auth/contacts.readonly');
                googleProvider
                    .setCustomParameters({'login_hint': 'user@example.com'});

                FirebaseAuth.instance.signInWithPopup(googleProvider);
              },
              icon: const Icon(Icons.login),
            );
          }
          return IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          );
        });
  }
}
