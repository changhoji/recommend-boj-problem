import 'package:flutter/material.dart';
import 'package:whattosolve/widgets/appbars/guest_appbar.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GuestAppBar(),
      body: Text('Guest'),
    );
  }
}
