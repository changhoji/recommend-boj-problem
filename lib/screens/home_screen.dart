import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whattosolve/services/firebase/database_service.dart';
import 'package:whattosolve/widgets/google_login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              DatabaseService.linkedHandle(user!.uid);
            },
            icon: const Icon(Icons.check_box),
          ),
          const GoogleLogin(),
          const SizedBox(width: 100),
        ],
      ),
      body: const Text("Home"),
    );
  }
}
