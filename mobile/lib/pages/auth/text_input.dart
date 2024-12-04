import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key, 
    required this.hintText, 
    required this.placeholder, 
    required this.obscureText, 
    required this.ctrler, 
    required this.borderColor,
    required this.errorMsg
  });

  final String hintText;
  final String placeholder;
  final bool obscureText;
  final TextEditingController ctrler;
  final Color borderColor;
  final String errorMsg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              hintText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),

        const SizedBox(height: 5),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: borderColor, width: 1) 
          ),
          child: Padding (
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              cursorColor: Colors.black,
              controller: ctrler,
              style: const TextStyle(
                color: Colors.black
              ),
              obscureText: obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16
                )
              ),
            ),
          ),
        ),

        const SizedBox(height: 2),

        errorMsg.isNotEmpty ? SizedBox(
          height: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                errorMsg,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 12
                ),
              )
            ],
          ),
        ) : const SizedBox(height: 16),
      ],
    );
  }
}