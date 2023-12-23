import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/texts/text_xx_small.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class MainButton extends StatelessWidget {
  final Color bg;
  final String text;
  final Icon? icon;
  final Function? onTap;
  final bool isLoading;
  final MaterialStateProperty<EdgeInsetsGeometry?>? padding;

  const MainButton({
    super.key,
    this.bg = primaryColor,
    required this.text,
    this.icon,
    this.isLoading = false,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? ElevatedButton.icon(
            onPressed: isLoading ? null : onTap as void Function()?,
            icon: Icon(
              icon?.icon,
              color: Colors.white,
              size: xm,
            ),
            label: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : TextXXSmall(
                    txt: text,
                    color: Colors.white,
                  ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(bg),
              padding: padding ??
                  MaterialStateProperty.all(const EdgeInsets.symmetric(
                    vertical: medium - 6,
                    horizontal: large,
                  )),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                  side: const BorderSide(
                    color: borderColor,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          )
        : ElevatedButton(
            onPressed: isLoading ? null : onTap as void Function()?,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(bg),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                vertical: xs + 2.5,
                horizontal: large * 1.2,
              )),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                  side: const BorderSide(
                    color: borderColor,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : TextXXSmall(txt: text, color: Colors.white),
          );
  }
}

class MainButtonOutlined extends StatelessWidget {
  final String text;
  final Icon icon;
  final bool isLoading;
  final void Function()? onTap;

  const MainButtonOutlined({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isLoading ? null : onTap,
      icon: Icon(
        icon.icon,
        color: Colors.grey,
        size: xm,
      ),
      label: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white),
            )
          : TextXXSmall(txt: text, color: Colors.white),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(mobBg),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
          vertical: xs + 2.5,
          horizontal: large * 1.2,
        )),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: const BorderSide(
              color: borderColor,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}
