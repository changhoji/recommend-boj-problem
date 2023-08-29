import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/filter.dart';
import 'package:whattosolve/services/solvedac_service.dart';

class LevelFilter extends StatefulWidget {
  const LevelFilter({super.key});

  @override
  State<LevelFilter> createState() => _LevelFilterState();
}

class _LevelFilterState extends State<LevelFilter> {
  var _rangeValues = const RangeValues(1, 30);

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
                    SolvedacService.levelToText(_rangeValues.start.round())
                        .data!,
                    SolvedacService.levelToText(_rangeValues.end.round()).data!,
                  ),
                  min: 1,
                  max: 30,
                  divisions: 29,
                  values: _rangeValues,
                  onChanged: (value) {
                    setState(() {
                      _rangeValues = value;
                    });
                    context.read<Filter>().level = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SolvedacService.levelToText(_rangeValues.start.round()),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('~'),
                    ),
                    SolvedacService.levelToText(_rangeValues.end.round()),
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
