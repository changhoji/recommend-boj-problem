import 'package:flutter/material.dart';
import 'package:whattosolve/widgets/google_login.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          GoogleLogin(),
          SizedBox(width: 100),
        ],
      ),
      body: const Text('Guest'),
    );
  }
}
