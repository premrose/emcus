import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool? obscureText;
  final String? Function(String?)? validator;
  const CommonTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF343131),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintStyle: TextStyle(color: Color(0XFF343131).withOpacity(0.5)),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0XFF707040)),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0XFF707040)),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
          validator: validator,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          onTapOutside:
              (event) => FocusManager.instance.primaryFocus?.unfocus(),
        ),
      ],
    );
  }
}
