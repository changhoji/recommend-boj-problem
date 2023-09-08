import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/models/solvedac_problem.dart';
import 'package:whattosolve/providers/search_filter.dart';
import 'package:whattosolve/services/firebase/firestore_service.dart';
import 'package:whattosolve/services/solvedac_service.dart';
import 'package:whattosolve/widgets/filter/handle_filter.dart';
import 'package:whattosolve/widgets/filter/level_filter.dart';
import 'package:whattosolve/widgets/filter/tag_filter.dart';
import 'package:whattosolve/widgets/google_login.dart';
import 'package:whattosolve/widgets/search_button.dart';
import 'package:whattosolve/widgets/suggestion_problem.dart';

class Tier {
  late Text text;

  Tier({required this.text});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final handle = TextEditingController();

  late Future<SolvedacProblem> suggestion;

  @override
  void initState() {
    super.initState();

    setState(() {
      suggestion =
          SolvedacService.getProblemWithFilter(context.read<SearchFilter>());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: const [
          GoogleLogin(),
          SizedBox(width: 100),
        ],
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: min(MediaQuery.of(context).size.width, 600),
              ),
              // filter container
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  const HandleFilter(),
                  const LevelFilter(),
                  const SizedBox(height: 20),
                  const TagFilter(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('한국어 문제만 찾기'),
                      Checkbox(
                        value: context.watch<SearchFilter>().translated,
                        onChanged: (value) {
                          context.read<SearchFilter>().reverseTranslated();
                        },
                      ),
                    ],
                  ),
                  const SearchButton(),
                  const SuggestionProblem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
