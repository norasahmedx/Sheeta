import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/images/picker.dart';
import 'package:sheeta/components/designs/texts/text_title.dart';
import 'package:sheeta/static/colors.dart';

class StepOne extends StatefulWidget {
  final Function updateImg;
  const StepOne({
    super.key,
    required this.updateImg,
  });

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobBg,
        title: const TextTitle(txt: 'New Post'),
      ),
      body:
          //TODO: Open gallery and fetch the image inside the app

          GestureDetector(
        onTap: () async {
          try {
            await Picker().showmodel(context, setState, widget.updateImg);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        child: const Center(
            child: Icon(
          Icons.upload,
          size: 55,
        )),
      ),
    );
  }
}
