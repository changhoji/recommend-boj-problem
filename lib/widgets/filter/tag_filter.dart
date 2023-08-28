import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/filter.dart';

class TagFilter extends StatelessWidget {
  const TagFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return const NowTagFilter();
  }
}

class NowTagFilter extends StatelessWidget {
  const NowTagFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: context.watch<Filter>().tags.map((tag) {
        return Row(
          children: [
            Text(tag.displayName),
            IconButton(
              onPressed: () {
                context.read<Filter>().removeTag(tag);
              },
              icon: const Icon(Icons.remove_circle_outline),
            )
          ],
        );
      }).toList(),
    );
  }
}
