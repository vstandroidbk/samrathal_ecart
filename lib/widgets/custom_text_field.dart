import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? textController;
  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool isImg;
  final bool isSuffixImg;
  final Widget? imgIcon;
  final Widget? imgSuffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final int maxLength;
  final int maxLine;
  final TextCapitalization? textCaps;
  final String? initialValue;
  final bool showPasswordVisibilityIcon;
  final Color textColor;
  final Color hintTextColor;
  final Color boxShadowColor;
  final Color boxColor;
  final TextAlign textAlign;
  final double blurRadius;
  final bool filled;
  final bool readOnly;
  final bool digitOnly;
  final List<TextInputFormatter> inputFormatter;
  final Radius borderRadius;

  const CustomTextField({
    Key? key,
    this.textController,
    this.hintText,
    this.inputFormatter = const [],
    this.prefixIcon,
    this.isImg = false,
    this.imgIcon,
    this.suffixIcon,
    this.isSuffixImg = false,
    this.imgSuffixIcon,
    this.onChanged,
    this.onTap,
    this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.maxLength = 100000,
    this.maxLine = 1,
    this.textCaps,
    this.initialValue,
    this.showPasswordVisibilityIcon = false,
    this.digitOnly = false,
    this.hintTextColor = Colors.grey,
    this.textColor = Colors.black,
    this.filled = false,
    this.boxColor = AppColors.textFieldBgColor,
    this.boxShadowColor = Colors.transparent,
    this.textAlign = TextAlign.start,
    this.blurRadius = 0.0,
    this.readOnly = false,
    this.borderRadius = const Radius.circular(0.0),
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool passwordIconVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 50.0,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(0.0),
        ),
        boxShadow: [
          BoxShadow(
            color: widget.boxShadowColor,
            spreadRadius: 0,
            blurRadius: widget.blurRadius,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: TextFormField(
        maxLines: widget.maxLine,
        textAlign: widget.textAlign,
        inputFormatters: widget.digitOnly
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : widget.inputFormatter,
        textCapitalization: widget.textCaps ?? TextCapitalization.none,
        obscureText: widget.showPasswordVisibilityIcon
            ? passwordIconVisibility == false
                ? true
                : false
            : false,
        controller: widget.textController,
        readOnly: widget.readOnly,
        maxLength: widget.maxLength,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        autofocus: false,
        style: TextStyle(
          decoration: TextDecoration.none,
          decorationThickness: 0,
          color: widget.readOnly ? Colors.black54 : widget.textColor,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            focusedBorder:
                TextFieldStyles.inputFocusedStyle(widget.borderRadius),
            enabledBorder:
                TextFieldStyles.inputBorderStyle(widget.borderRadius),
            errorBorder: TextFieldStyles.inputBorderStyle(widget.borderRadius),
            focusedErrorBorder:
                TextFieldStyles.inputBorderStyle(widget.borderRadius),
            filled: true,
            fillColor: widget.boxColor,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: widget.hintTextColor,
              fontSize: 14.0,
            ),
            counterText: "",
            prefixIconConstraints:
                const BoxConstraints(minHeight: 25.0, minWidth: 25.0),
            prefixIcon: widget.isImg
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 5.0),
                    child: widget.imgIcon,
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                    child: widget.prefixIcon,
                  ),
            suffixIcon: widget.showPasswordVisibilityIcon
                ? GestureDetector(
                    child: passwordIconVisibility == true
                        ? const Icon(
                            CupertinoIcons.eye_slash_fill,
                            color: AppColors.textHintColor,
                            size: 28.0,
                          )
                        : const Icon(
                            CupertinoIcons.eye_solid,
                            color: AppColors.textHintColor,
                            size: 28.0,
                          ),
                    onTap: () {
                      if (widget.showPasswordVisibilityIcon) {
                        passwordIconVisibility == false
                            ? passwordIconVisibility = true
                            : passwordIconVisibility = false;
                        setState(() {});
                      }
                    },
                  )
                : widget.isSuffixImg
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: widget.imgSuffixIcon,
                      )
                    : widget.suffixIcon),
      ),
    );
  }
}

class TextFieldStyles {
  TextFieldStyles._();

  static OutlineInputBorder inputBorderStyle(Radius radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(radius),
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
    );
  }

  static OutlineInputBorder inputFocusedStyle(Radius radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(radius),
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 1,
      ),
    );
  }
}
