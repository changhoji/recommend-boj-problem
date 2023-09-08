import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/search_filter.dart';
import 'package:whattosolve/services/solvedac_service.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: context.watch<SearchFilter>().searching
          ? LoadingAnimationWidget.threeArchedCircle(
              color: Colors.grey.shade600,
              size: 20,
            )
          : IconButton(
              mouseCursor: (context.watch<SearchFilter>().handleSearched &&
                      context.watch<SearchFilter>().handleExists)
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              onPressed: () {
                if (!context.read<SearchFilter>().handleSearched ||
                    !context.read<SearchFilter>().handleExists) return;

                context.read<SearchFilter>().searching = true;
                SolvedacService.getProblemWithFilter(
                        context.read<SearchFilter>())
                    .then((value) {
                  context.read<SearchFilter>().suggestion = value;
                  context.read<SearchFilter>().searching = false;
                });

                context.read<SearchFilter>().searched = true;
              },
              icon: Icon(
                Icons.search,
                color: (context.watch<SearchFilter>().handleSearched &&
                        context.watch<SearchFilter>().handleExists)
                    ? Colors.black
                    : Colors.grey,
              ),
            ),
    );
  }
}
