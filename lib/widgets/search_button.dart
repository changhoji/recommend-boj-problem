import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/filter.dart';
import 'package:whattosolve/services/solvedac_service.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        SolvedacService.getProblemWithFilter(context.read<Filter>())
            .then((value) {
          context.read<Filter>().suggestion = value;
        });
        context.read<Filter>().searched = true;
      },
      icon: const Icon(Icons.search),
    );
  }
}
