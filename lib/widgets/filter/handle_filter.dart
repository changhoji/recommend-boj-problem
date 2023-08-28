import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/filter.dart';

class HandleFilter extends StatelessWidget {
  const HandleFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        context.read<Filter>().handle = value;
      },
    );
  }
}
