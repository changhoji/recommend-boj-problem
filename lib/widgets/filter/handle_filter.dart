import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  final FocusNode _focusNode = FocusNode();
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      // update handle value
      context.read<Filter>().handle = _controller.text;
      String handle = _controller.text;

      if (!_focusNode.hasFocus) {
        if (handle.isEmpty) {
          // when empty, handle is valid
          context.read<Filter>().handleExists = true;
          context.read<Filter>().handleSearched = true;
          return;
        }
        // search whether handle is exist
        context.read<Filter>().handleExists = false;
        context.read<Filter>().handleSearched = false;
        SolvedacService.isExistingHandle(handle).then((exist) {
          context.read<Filter>().handleSearched = true;
          context.read<Filter>().handleExists = exist;
        });
      } else {
        // for disable search button
        context.read<Filter>().handleSearched = false;
      }
    });
  }

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
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            TextField(
              focusNode: _focusNode,
              controller: _controller,
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
            ),
            !context.watch<Filter>().handleSearched
                ? Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
