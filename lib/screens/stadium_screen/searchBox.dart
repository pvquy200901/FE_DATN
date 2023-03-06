import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';

class SearchBox extends StatelessWidget {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35),
      child: AnimSearchBar(
        width: 350,
        textController: textController,
        onSuffixTap: () {},
        onSubmitted: (String) {},
        helpText: "Tìm kiếm",
        animationDurationInMilli: 1000,
      ),
    );
  }
}
