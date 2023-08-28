import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/filter.dart';
import 'package:whattosolve/services/solvedac_service.dart';

const tiers = SolvedacService.tiers;
const List<String> levels = ['1', '2', '3', '4', '5'];

class LevelFilter extends StatefulWidget {
  const LevelFilter({super.key});

  @override
  State<LevelFilter> createState() => _LevelFilterState();
}

class _LevelFilterState extends State<LevelFilter> {
  Text fromTier = tiers.last;
  String fromLevel = levels.last;

  Text toTier = tiers.first;
  String toLevel = levels.first;

  updateLevel(BuildContext context) {
    context.read<Filter>().level =
        ("${levelToString(fromTier.data!, fromLevel)}..${levelToString(toTier.data!, toLevel)}");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton(
          value: fromTier,
          onChanged: (value) {
            setState(() {
              fromTier = value!;
            });
            updateLevel(context);
          },
          items: tiers.map((tier) {
            return DropdownMenuItem(
              value: tier,
              child: tier,
            );
          }).toList(),
        ),
        DropdownButton(
          value: fromLevel,
          items: levels.map((level) {
            return DropdownMenuItem(
              value: level,
              child: Text(level, style: fromTier.style),
            );
          }).toList(),
          onChanged: ((value) {
            setState(() {
              fromLevel = value!;
            });
            updateLevel(context);
          }),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("~"),
        ),
        DropdownButton(
          value: toTier,
          onChanged: (value) {
            setState(() {
              toTier = value!;
            });
            updateLevel(context);
          },
          items: tiers.map((tier) {
            return DropdownMenuItem(
              value: tier,
              child: tier,
            );
          }).toList(),
        ),
        DropdownButton(
          value: toLevel,
          items: levels.map((level) {
            return DropdownMenuItem(
              value: level,
              child: Text(level, style: toTier.style),
            );
          }).toList(),
          onChanged: ((value) {
            setState(() {
              toLevel = value!;
            });
            updateLevel(context);
          }),
        ),
      ],
    );
  }
}

String levelToString(String tier, String level) {
  return "${tier[0].toLowerCase()}$level";
}
