import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/texts/text_xx_small.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/static/sizes.dart';

class Bio extends StatefulWidget {
  final UserData? userInfo;
  final bool editMode;
  final TextEditingController bioController;
  final TextEditingController usernameController;
  final FocusNode usernameFocus;
  final String? usernameError;
  const Bio({
    super.key,
    required this.userInfo,
    required this.editMode,
    required this.bioController,
    required this.usernameController,
    required this.usernameFocus,
    required this.usernameError,
  });

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  @override
  void dispose() {
    widget.bioController.dispose();
    widget.usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.editMode) {
      return Container(
        margin:
            const EdgeInsets.symmetric(horizontal: medium, vertical: medium),
        child: TextXXSmall(txt: widget.userInfo!.bio),
      );
    } else {
      return Container(
          margin:
              const EdgeInsets.symmetric(horizontal: medium, vertical: medium),
          child: Column(
            children: [
              TextFormField(
                controller: widget.usernameController,
                focusNode: widget.usernameFocus,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: widget.userInfo!.username,
                  border: InputBorder.none,
                  hintStyle: const TextStyle(fontSize: xxm),
                  errorText: widget.usernameError, // Use the error message
                ),
              ),
              TextFormField(
                controller: widget.bioController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: widget.userInfo!.bio,
                  border: InputBorder.none,
                  hintStyle: const TextStyle(fontSize: xxm),
                ),
              ),
            ],
          ));
    }
  }
}
