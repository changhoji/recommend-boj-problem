import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/models/solvedac_problem.dart';
import 'package:whattosolve/providers/filter.dart';
import 'package:whattosolve/widgets/tag_search.dart';

class TagFilter extends StatelessWidget {
  const TagFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TagList(
          title: '포함할 태그',
          tags: context.watch<Filter>().containTags,
          onPressed: (Tag tag) {
            context.read<Filter>().removeContainTag(tag);
          },
        ),
        TagList(
          title: '제외할 태그',
          tags: context.watch<Filter>().exceptTags,
          onPressed: (Tag tag) {
            context.read<Filter>().removeExceptTag(tag);
          },
        ),
        const TagSearch(),
      ],
    );
  }
}

class TagList extends StatelessWidget {
  final String title;
  final List<Tag> tags;
  final void Function(Tag) onPressed;

  const TagList({
    super.key,
    required this.title,
    required this.tags,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(title),
        children: [
          Column(
            children: tags.map((tag) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text(tag.displayName),
                    IconButton(
                      onPressed: () {
                        onPressed(tag);
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 20,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
