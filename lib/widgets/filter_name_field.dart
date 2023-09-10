import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/controllers.dart';
import 'package:whattosolve/providers/search_filter.dart';

class FilterNameField extends StatelessWidget {
  const FilterNameField({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();

    focusNode.addListener(() {
      context.read<SearchFilter>().filterName =
          context.read<Controllers>().filterNameController.text;
    });

    return TextField(
      maxLength: 10,
      controller: context.watch<Controllers>().filterNameController,
      focusNode: focusNode,
    );
  }
}
