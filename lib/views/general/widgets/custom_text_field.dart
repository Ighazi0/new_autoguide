import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hint;
  final bool secure;
  final TextInputType? type;
  final int? length;
  final Function? onChange, onSubmit;
  final Iterable<String>? autofill;
  const CustomTextField({
    super.key,
    this.secure = false,
    this.controller,
    this.validator,
    this.autofill,
    required this.hint,
    this.length,
    this.onChange,
    this.onSubmit,
    this.type,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      validator: widget.validator,
      maxLength: widget.length == 0 ? null : widget.length,
      minLines: widget.type == TextInputType.multiline ? null : 1,
      maxLines: widget.type == TextInputType.multiline ? 3 : 1,
      onChanged: (value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      onFieldSubmitted: (w) {
        if (widget.onSubmit != null) {
          widget.onSubmit!(w);
        }
      },
      autofillHints: widget.autofill,
      controller: widget.controller,
      keyboardType: widget.type,
      inputFormatters: widget.type == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      obscureText: widget.secure ? showPass : false,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        suffixIcon: widget.secure
            ? IconButton(
                onPressed: (() {
                  setState(() {
                    showPass = !showPass;
                  });
                }),
                icon: Icon(
                  !showPass ? Icons.visibility : Icons.visibility_off,
                  color: AppStyle.primaryColor,
                  size: 16,
                ),
              )
            : null,
        hintText: widget.hint.tr,
        focusedBorder: OutlineInputBorder(
          borderRadius: AppStyle.borderRadius,
          borderSide: BorderSide(color: Colors.black),
        ),
        border: OutlineInputBorder(borderRadius: AppStyle.borderRadius),
      ),
    );
  }
}
