import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/search_filter.dart';
import 'package:whattosolve/services/firebase/firestore_service.dart';

class FilterSaveButton extends StatelessWidget {
  const FilterSaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          return IconButton(
            onPressed: () {
              FirestoreService.saveFilter(
                  user.uid, context.read<SearchFilter>());
            },
            icon: const Icon(Icons.save),
          );
        }
        return IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) =>
                  const AlertDialog(title: Text('먼저 로그인 해주세요')),
            );
          },
          icon: const Icon(Icons.save),
          color: Colors.grey,
        );
      },
    );
  }
}
