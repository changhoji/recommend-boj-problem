import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whattosolve/models/firestore_problem.dart';
import 'package:whattosolve/services/firebase/firestore_service.dart';
import 'package:whattosolve/services/solvedac_service.dart';
import 'package:whattosolve/widgets/appbars/user_appbar.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const UserAppBar(),
        body: StreamBuilder(
          stream: FirestoreService.bookmarkSnapshot(
              FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final problems = snapshot.data!;
              return Center(
                child: Column(
                  children: problems.docs
                      .map((doc) => BookmarkItem(doc: doc))
                      .toList(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}

class BookmarkItem extends StatelessWidget {
  final QueryDocumentSnapshot<FirestoreProblem> doc;

  const BookmarkItem({
    super.key,
    required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrlString('https://acmicpc.net/problem/${doc.id}');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: 600,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  SolvedacService.levelToText(doc.data().level),
                  Text('${doc.id}번: ${doc.data().titleKo}'),
                  SingleChildScrollView(
                    child: Row(
                      children: doc
                          .data()
                          .tags
                          .map(
                            (tag) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(tag),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                FirestoreService.removeBookmark(
                    FirebaseAuth.instance.currentUser!.uid, doc.id);
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
