import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool isSecret;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Color? labelTextColor;
  final bool boldLabel;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.keyboardType,
    this.isSecret = false,
    this.validator,
    this.onChanged,
    this.controller,
    this.labelTextColor,
    this.boldLabel = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      key: widget.key,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        hintText: widget.labelText,
        suffixIcon: widget.isSecret
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText
                      ? Icons.visibility_off_sharp
                      : Icons.remove_red_eye_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
