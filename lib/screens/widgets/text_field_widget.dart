import 'package:flutter/material.dart';
import '../../helper/validation_helper.dart';
import '/utils/color_resources.dart';
import '/utils/dimensions.dart';
import 'package:get/get.dart';
import '/utils/language/key_language.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final Key? fieldKey;
  final bool isPasswordField;
  final bool? isSearchField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final bool autoFocus;
  final String? error;
  final double? height;
  final Widget? suffixIcon;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.fieldKey,
    this.isPasswordField = false,
    this.isSearchField,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    this.autoFocus = false,
    this.error,
    this.height,
    this.suffixIcon,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        style: TextStyle(color: ColorResources.getBlackColor()),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField ? _obscureText : false,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator ??
            (value) {
              return ValidationHelper.validNull(value);
            },
        autofocus: widget.autoFocus,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle:
              TextStyle(color: ColorResources.getGreyColor(), fontSize: 16),
          floatingLabelStyle:
              TextStyle(color: ColorResources.getBlackColor(), fontSize: 16),
          prefixIcon:
              widget.isSearchField == true ? const Icon(Icons.search) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorResources.getBlackColor().withOpacity(0.5),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorResources.getBlackColor(), width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: widget.isPasswordField == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _obscureText
                        ? ColorResources.getBlackColor().withOpacity(0.5)
                        : Theme.of(context).primaryColor.withOpacity(0.8),
                  ))
              : widget.suffixIcon,
        ),
      ),
    );
  }
}
