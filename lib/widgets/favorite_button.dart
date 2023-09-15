import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/search_filter.dart';
import 'package:whattosolve/services/firebase/firestore_service.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (FirebaseAuth.instance.currentUser == null) {
          showDialog(
            context: context,
            builder: (context) => const AlertDialog(
              title: Text('먼저 로그인 해주세요!'),
            ),
          );
          return;
        }

        FirestoreService.addFavorite(FirebaseAuth.instance.currentUser!.uid,
            context.read<SearchFilter>().suggestion!);
      },
      icon: const Icon(Icons.favorite_border),
    );
  }
}
