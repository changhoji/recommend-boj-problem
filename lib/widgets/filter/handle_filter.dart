import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattosolve/providers/filter.dart';
import 'package:whattosolve/services/solvedac_service.dart';

class HandleFilter extends StatefulWidget {
  const HandleFilter({
    super.key,
  });

  @override
  State<HandleFilter> createState() => _HandleFilterState();
}

class _HandleFilterState extends State<HandleFilter> {
  String handle = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '백준 핸들',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Focus(
          onFocusChange: (value) {
            if (!value && handle.isNotEmpty) {
              context.read<Filter>().handleSearched = false;
              SolvedacService.isExistingHandle(handle).then((exist) {
                context.read<Filter>().handleSearched = true;
                context.read<Filter>().handleExists = exist;
              });
            } else if (value) {
              context.read<Filter>().handleExists = false;
            } else if (handle.isEmpty) {
              context.read<Filter>().handleExists = true;
            }
          },
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: context.watch<Filter>().handleSearched
                          ? (context.watch<Filter>().handleExists
                              ? Colors.green
                              : Colors.red)
                          : Colors.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  context.read<Filter>().handle = value;
                  handle = value;
                },
              ),
              !context.watch<Filter>().handleSearched
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_circle_down_sharp,
                        color: Colors.grey.shade700,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
