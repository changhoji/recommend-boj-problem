import 'package:flutter/material.dart';
import 'package:whattosolve/widgets/google_login.dart';

class GuestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GuestAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: const [
        GoogleLogin(),
        SizedBox(width: 100),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
