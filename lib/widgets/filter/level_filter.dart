import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/search_filter.dart';
import 'package:whattosolve/services/solvedac_service.dart';

class LevelFilter extends StatefulWidget {
  const LevelFilter({super.key});

  @override
  State<LevelFilter> createState() => _LevelFilterState();
}

class _LevelFilterState extends State<LevelFilter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '난이도 설정',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.grey.shade200,
            ),
            child: Column(
              children: [
                RangeSlider(
                  labels: RangeLabels(
                    SolvedacService.levelToText(
                            context.watch<SearchFilter>().levelStart.round())
                        .data!,
                    SolvedacService.levelToText(
                            context.watch<SearchFilter>().levelEnd.round())
                        .data!,
                  ),
                  min: 1,
                  max: 30,
                  divisions: 29,
                  values: RangeValues(
                    context.watch<SearchFilter>().levelStart.toDouble(),
                    context.watch<SearchFilter>().levelEnd.toDouble(),
                  ),
                  onChanged: (value) {
                    context.read<SearchFilter>().levelStart =
                        value.start.round();
                    context.read<SearchFilter>().levelEnd = value.end.round();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SolvedacService.levelToText(
                        context.watch<SearchFilter>().levelStart.round()),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('~'),
                    ),
                    SolvedacService.levelToText(
                        context.watch<SearchFilter>().levelEnd.round()),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
