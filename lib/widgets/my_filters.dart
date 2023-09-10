import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/models/firestore_filter.dart';
import 'package:whattosolve/providers/controllers.dart';
import 'package:whattosolve/providers/search_filter.dart';
import 'package:whattosolve/providers/tags.dart';

class MyFilters extends StatefulWidget {
  const MyFilters({super.key});

  @override
  State<MyFilters> createState() => _MyFiltersState();
}

class _MyFiltersState extends State<MyFilters> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!;
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .collection("filters")
                .withConverter(
                  fromFirestore: FirestoreFilter.fromFirestore,
                  toFirestore: (value, options) => value.toFirestore(),
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return SizedBox(
                  width: 600,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: docs.map((doc) {
                      final data = SearchFilter.fromFirestoreFilter(doc.data(),
                          int.parse(doc.id), context.read<Tags>().tags!);
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: (context.watch<SearchFilter>().id.toString() ==
                                  doc.id)
                              ? Colors.blue.shade100
                              : Colors.grey.shade200,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15.0,
                        ),
                        child: InkWell(
                          child: Text(data.filterName),
                          onTap: () {
                            context.read<SearchFilter>().assignNewFilter(data);
                            context
                                .read<Controllers>()
                                .changeHandle(data.handle);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
