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
        ExceptTags(),
      ],
    );
  }
}

class ContainTags extends StatelessWidget {
  const ContainTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '포함할 태그',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Container(
          width: 600,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            children: context.watch<Filter>().containTags.map((tag) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(tag.displayName),
                    IconButton(
                      onPressed: () {
                        context.read<Filter>().removeContainTag(tag);
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 20,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ExceptTags extends StatelessWidget {
  const ExceptTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '제외할 태그',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Container(
          width: 600,
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: context.watch<Filter>().exceptTags.map((tag) {
              return Row(
                children: [
                  Text(tag.displayName),
                  IconButton(
                    onPressed: () {
                      context.read<Filter>().removeExceptTag(tag);
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    iconSize: 20,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
