import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/buttons/main_button.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/models/user.dart';
import 'package:sheeta/shared/show_toast.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class ProfileActionArea extends StatefulWidget {
  final UserData? userInfo;
  final bool? isItMe;
  final Function updateFollowers;
  final bool follow;
  final bool followback;
  final bool editMode;
  final TextEditingController bioController;
  final TextEditingController usernameController;
  final FocusNode usernameFocus;
  final Function() switchEditMode;
  final Function(String? msg) addUsernameError;
  final Function updateUserInfo;
  const ProfileActionArea({
    super.key,
    required this.userInfo,
    required this.isItMe,
    required this.updateFollowers,
    required this.follow,
    required this.followback,
    required this.editMode,
    required this.bioController,
    required this.usernameController,
    required this.usernameFocus,
    required this.switchEditMode,
    required this.addUsernameError,
    required this.updateUserInfo,
  });

  @override
  State<ProfileActionArea> createState() => _ProfileActionAreaState();
}

class _ProfileActionAreaState extends State<ProfileActionArea> {
  bool isLoading = false;

  followHandlerBtn() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    if (widget.follow) {
      //* remove follow & unfollow work
      await Auth().followSwitch(
        context: context,
        user: widget.userInfo,
        type: 'remove',
      );
    } else {
      //* add follow & unfollow work
      await Auth().followSwitch(
        context: context,
        user: widget.userInfo,
        type: 'add',
      );
    }

    await widget.updateFollowers();
    //* toggle the button
    // follow = !follow
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  updateProfile() async {
    if (!widget.editMode) {
      // Turn on the edit mode
      widget.switchEditMode();
      return;
    }

    String biotxt = widget.bioController.text;
    String usernametxt = widget.usernameController.text;

    // Check if the username and bio have changed
    bool isUsernameChanged =
        usernametxt.isNotEmpty && usernametxt != widget.userInfo!.username;
    bool isBioChanged = biotxt.isNotEmpty && biotxt != widget.userInfo!.bio;

    if (!isUsernameChanged && !isBioChanged) {
      // If neither username nor bio has changed, exit without updating
      widget.switchEditMode();
      return;
    }

    // Check if the username is the same as the current username
    if (isUsernameChanged) {
      // Check if the username is unique
      bool isUnique = await Auth().uniqueField('username', usernametxt);

      // Validate username
      if (!isUnique) {
        if (!mounted) return;
        setState(() {
          widget.addUsernameError('Username is already in use');
        });
        widget.usernameFocus.requestFocus();
        return;
      }

      // Remove spaces and convert to lowercase
      usernametxt = usernametxt.replaceAll(' ', '-').toLowerCase();

      // Clear username error
      setState(() {
        widget.addUsernameError(null);
      });
    }

    // Set default values if fields are empty
    String bio = isBioChanged ? biotxt : widget.userInfo!.bio;
    String username =
        isUsernameChanged ? usernametxt : widget.userInfo!.username;

    // Update the data in Firebase
    if (!mounted) return;
    bool valid =
        await Auth().update(context: context, bio: bio, username: username);

    if (valid) {
      // Update the user data
      await widget.updateUserInfo();
      showToast('Your profile updated successfully');
      // Turn off the edit mode
      widget.switchEditMode();
    } else {
      showToast('Something went wrong, please try again later');
      // Turn off the edit mode
      widget.switchEditMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isItMe!) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainButtonOutlined(
            onTap: updateProfile,
            icon: widget.editMode
                ? const Icon(Icons.upload)
                : const Icon(Icons.edit),
            text: widget.editMode ? 'Update Profile' : 'Edit Profile',
          ),
          const SizedBox(width: medium),
          const MainButtonOutlined(
              icon: Icon(Icons.share), text: 'Share Profile'),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.follow
              // if the user following him already
              ? MainButton(
                  isLoading: isLoading,
                  onTap: followHandlerBtn,
                  icon: const Icon(Icons.person_remove_sharp),
                  text: 'unfollow',
                  bg: blueColor,
                )
              // if th user is NOT following him
              : MainButton(
                  isLoading: isLoading,
                  onTap: followHandlerBtn,
                  icon: const Icon(Icons.person_add),
                  text: widget.followback ? 'follow back' : 'follow him',
                  bg: primaryColor,
                ),
          const SizedBox(width: medium),
          const MainButtonOutlined(
              icon: Icon(Icons.share), text: 'Share Profile'),
        ],
      );
    }
  }
}
