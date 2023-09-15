import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:whattosolve/models/solvedac_problem.dart';
import 'package:whattosolve/providers/search_filter.dart';
import 'package:whattosolve/providers/tags.dart';

class TagSearch extends StatefulWidget {
  const TagSearch({super.key});

  @override
  State<TagSearch> createState() => _TagSearchState();
}

class _TagSearchState extends State<TagSearch> {
  final controller = TextEditingController();
  String text = "";
  List<Tag> searchedTags = <Tag>[];

  @override
  Widget build(BuildContext context) {
    return SearchField<Tag>(
      onSearchTextChanged: (searchKey) {
        // Select tags whose displayName or key contains key
        return context
            .read<Tags>()
            .tags!
            .where((tag) => (tag.displayName.contains(searchKey) ||
                tag.key.contains(searchKey)))
            .toList()
            .map((tag) => tagItem(context, tag, controller))
            .toList();
      },
      controller: controller,
      suggestions: context
          .read<Tags>()
          .tags!
          .map((tag) => tagItem(context, tag, controller))
          .toList(),
      onSuggestionTap: (tag) {
        context.watch<SearchFilter>().addContainTag(tag.item!);
      },
    );
  }
}

/// Make each row of searched tag
///
/// Each row contains displayName, key, add button, and remove button
SearchFieldListItem<Tag> tagItem(
    BuildContext context, Tag tag, TextEditingController controller) {
  return SearchFieldListItem(
    tag.displayName,
    item: tag,
    child: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(tag.displayName),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '#${tag.key}',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.add),
              iconSize: 15,
              onPressed: () {
                context.read<SearchFilter>().addContainTag(tag);
                controller.clear();
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: const Icon(Icons.remove),
              iconSize: 15,
              onPressed: () {
                context.read<SearchFilter>().addExceptTag(tag);
                controller.clear();
              },
            ),
          ),
        ],
      ),
    ),
  );
}
