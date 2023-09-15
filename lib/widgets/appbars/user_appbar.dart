import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whattosolve/widgets/google_login.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('What To Solve?'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: InkWell(
            child: const Center(
              child: Text(
                '문제추천',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              context.go('/');
            },
          ),
        ),
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  child: const Center(
                    child: Text(
                      '북마크',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    context.go('/bookmark');
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: GoogleLogin(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
