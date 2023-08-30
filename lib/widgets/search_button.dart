import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/filter.dart';
import 'package:whattosolve/services/solvedac_service.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      mouseCursor: (context.watch<Filter>().handleSearched &&
              context.watch<Filter>().handleExists)
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onPressed: () {
        if (!context.read<Filter>().handleSearched ||
            !context.read<Filter>().handleExists) return;
        SolvedacService.getProblemWithFilter(context.read<Filter>())
            .then((value) {
          context.read<Filter>().suggestion = value;
        });

        context.read<Filter>().searched = true;
      },
      icon: Icon(
        Icons.search,
        color: (context.watch<Filter>().handleSearched &&
                context.watch<Filter>().handleExists)
            ? Colors.black
            : Colors.grey,
      ),
    );
  }
}
