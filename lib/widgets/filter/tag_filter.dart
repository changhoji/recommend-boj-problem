import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/filter.dart';

class TagFilter extends StatelessWidget {
  const TagFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ContainTags(),
        SizedBox(height: 50),
        ExceptTags(),
      ],
    );
  }
}

class ContainTags extends StatelessWidget {
  const ContainTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [
          const Text('containFilter'),
          ...context.watch<Filter>().containTags.map((tag) {
            return Row(
              children: [
                Text(tag.displayName),
                IconButton(
                  onPressed: () {
                    context.read<Filter>().removeContainTag(tag);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ExceptTags extends StatelessWidget {
  const ExceptTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [
          const Text('exceptFilter'),
          ...context.watch<Filter>().exceptTags.map((tag) {
            return Row(
              children: [
                Text(tag.displayName),
                IconButton(
                  onPressed: () {
                    context.read<Filter>().removeExceptTag(tag);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
