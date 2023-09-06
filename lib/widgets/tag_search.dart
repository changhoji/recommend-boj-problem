import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:whattosolve/models/solvedac_problem.dart';
import 'package:whattosolve/providers/filter.dart';
import 'package:whattosolve/services/solvedac_service.dart';

class TagSearch extends StatefulWidget {
  const TagSearch({super.key});

  @override
  State<TagSearch> createState() => _TagSearchState();
}

class _TagSearchState extends State<TagSearch> {
  late Future<List<Tag>> tagList;
  final controller = TextEditingController();
  String text = "";
  List<Tag> searchedTags = <Tag>[];

  @override
  void initState() {
    super.initState();
    tagList = SolvedacService.getTags();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tagList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SearchField<Tag>(
            onSearchTextChanged: (key) {
              return snapshot.data!
                  .where((tag) =>
                      (tag.displayName.contains(key) || tag.key.contains(key)))
                  .toList()
                  .map((tag) => tagItem(context, tag, controller))
                  .toList();
            },
            controller: controller,
            suggestions: snapshot.data!
                .map((tag) => tagItem(context, tag, controller))
                .toList(),
            onSuggestionTap: (tag) {
              context.read<Filter>().addContainTag(tag.item!);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

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
                context.read<Filter>().addContainTag(tag);
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
                context.read<Filter>().addExceptTag(tag);
                controller.clear();
              },
            ),
          ),
        ],
      ),
    ),
  );
}
