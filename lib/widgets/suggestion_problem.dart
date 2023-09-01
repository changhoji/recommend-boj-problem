import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whattosolve/models/solvedac_problem.dart';
import 'package:whattosolve/providers/filter.dart';
import 'package:whattosolve/services/solvedac_service.dart';

const tiers = SolvedacService.tiers;

class SuggestionProblem extends StatelessWidget {
  const SuggestionProblem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: (context.watch<Filter>().suggestion != null)
          ? const ProblemInfo()
          : null,
    );
  }
}

class ProblemInfo extends StatelessWidget {
  const ProblemInfo({super.key});

  @override
  Widget build(BuildContext context) {
    SolvedacProblem suggestion = context.watch<Filter>().suggestion!;
    return Column(
      children: [
        InkWell(
            child: Column(
              children: [
                Text(
                  "난이도: ${tiers[5 - (suggestion.level - 1) ~/ 5].data}${5 - (suggestion.level - 1) % 5}",
                  style: tiers[5 - (suggestion.level - 1) ~/ 5].style!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text('${suggestion.problemId}번: ${suggestion.titleKo}'),
              ],
            ),
            onTap: () {
              launchUrlString(
                  "https://acmicpc.net/problem/${suggestion.problemId}");
            }),
        ExpansionTile(
          title: const Text('태그'),
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: suggestion.tags.map((tag) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TagSection(tag: tag));
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TagSection extends StatelessWidget {
  final Tag tag;
  const TagSection({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Row(
        children: [
          Text(tag.displayName),
          IconButton(
            onPressed: () {
              context.read<Filter>().addContainTag(tag);
            },
            iconSize: 20,
            icon: const Icon(Icons.add_circle_outline),
          ),
          IconButton(
            onPressed: () {
              context.read<Filter>().addExceptTag(tag);
            },
            iconSize: 20,
            icon: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
    );
  }
}
