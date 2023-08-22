import 'package:flutter/material.dart';

const List<Text> tiers = [
  Text('Ruby', style: TextStyle(color: Colors.red)),
  Text('Diamond', style: TextStyle(color: Colors.cyan)),
  Text('Platinum', style: TextStyle(color: Colors.green)),
  Text('Gold', style: TextStyle(color: Colors.orange)),
  Text('Silver', style: TextStyle(color: Colors.grey)),
  Text('Bronze', style: TextStyle(color: Colors.brown)),
];

const List<String> levels = ['1', '2', '3', '4', '5'];

class LevelSelect extends StatefulWidget {
  const LevelSelect({super.key});

  @override
  State<LevelSelect> createState() => _LevelSelectState();
}

class _LevelSelectState extends State<LevelSelect> {
  Text tier = tiers.first;
  String level = levels.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton(
          value: tier,
          onChanged: (value) {
            setState(() {
              tier = value!;
            });
          },
          items: List.generate(tiers.length, (i) {
            return DropdownMenuItem(
              value: tiers[i],
              child: tiers[i],
            );
          }),
        ),
        DropdownButton(
          value: level,
          items: levels.map((level) {
            return DropdownMenuItem(
              value: level,
              child: Text(level, style: tier.style),
            );
          }).toList(),
          onChanged: ((value) {
            setState(() {
              level = value!;
            });
          }),
        ),
      ],
    );
  }
}
