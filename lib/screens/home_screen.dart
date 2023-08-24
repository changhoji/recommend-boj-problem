import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/models/solvedac_problem.dart';
import 'package:whattosolve/providers/level.dart';
import 'package:whattosolve/services/solvedac_service.dart';
import 'package:whattosolve/widgets/filter/level_select_widget.dart';
import 'package:whattosolve/widgets/google_login.dart';

const List<Text> tiers = [
  Text('Ruby', style: TextStyle(color: Colors.red)),
  Text('Diamond', style: TextStyle(color: Colors.cyan)),
  Text('Platinum', style: TextStyle(color: Colors.green)),
  Text('Gold', style: TextStyle(color: Colors.orange)),
  Text('Silver', style: TextStyle(color: Colors.grey)),
  Text('Bronze', style: TextStyle(color: Colors.brown)),
];

const List<String> levels = ['1', '2', '3', '4', '5'];

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

  Text tier = tiers.first;
  String level = levels.first;

  late Future<SolvedacProblem> suggestion;

  @override
  void initState() {
    super.initState();

    setState(() {
      suggestion = SolvedacService.getProblemWithFilter("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          GoogleLogin(),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        // filter container
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            TextField(
              controller: handle,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const LevelSelect(),
            // Row(
            //   children: [
            //     DropdownButton(
            //       value: tier,
            //       onChanged: (value) {
            //         setState(() {
            //           tier = value!;
            //         });
            //       },
            //       items: List.generate(tiers.length, (i) {
            //         return DropdownMenuItem(
            //           value: tiers[i],
            //           child: tiers[i],
            //         );
            //       }),
            //     ),
            //     DropdownButton(
            //       value: level,
            //       items: levels.map((level) {
            //         return DropdownMenuItem(
            //           value: level,
            //           child: Text(level, style: tier.style),
            //         );
            //       }).toList(),
            //       onChanged: ((value) {
            //         setState(() {
            //           level = value!;
            //         });
            //       }),
            //     ),
            //   ],
            // ),
            IconButton(
              onPressed: () {
                setState(() {
                  suggestion = SolvedacService.getProblemWithFilter(
                      "*${context.read<Level>().level}");
                  // "*${getLevel(tier.data!, int.parse(level))}");
                });
              },
              icon: const Icon(Icons.search),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.green.shade100),
              child: FutureBuilder(
                future: suggestion,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                        '${snapshot.data!.level}/${snapshot.data!.titleKo}');
                  }
                  return const Text("...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int getLevel(String tier, int level) {
  int base;

  switch (tier) {
    case "Ruby":
      base = 25;
      break;
    case "Diamond":
      base = 20;
      break;
    case "Platinum":
      base = 15;
      break;
    case "Gold":
      base = 10;
      break;
    case "Silver":
      base = 5;
      break;
    default:
      base = 0;
      break;
  }

  return base + (6 - level);
}
