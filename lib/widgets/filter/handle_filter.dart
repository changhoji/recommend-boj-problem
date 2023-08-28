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
  bool validHandle = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '백준 핸들',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.0,
                  color: validHandle ? Colors.green : Colors.red,
                ),
              ),
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) {
              context.read<Filter>().handle = value;
              handle = value;
            },
            onTapOutside: (e) {
              if (handle.isNotEmpty) {
                SolvedacService.isExistingHandle(handle).then(
                  (exist) {
                    setState(() {
                      validHandle = exist;
                    });
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
