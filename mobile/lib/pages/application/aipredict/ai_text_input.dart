import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class AITextInput extends StatelessWidget {
  const AITextInput({
    super.key, 
    required this.hintText, 
    required this.placeholder, 
    required this.obscureText, 
    required this.ctrler, 
    required this.borderColor,
    required this.errorMsg,
    required this.theme
  });

  final String hintText;
  final String placeholder;
  final bool obscureText;
  final TextEditingController ctrler;
  final Color borderColor;
  final String errorMsg;
  final String theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              hintText,
              style:  TextStyle(
                color: theme == 'light' ? Colors.black : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            )
          ],
        ),

        const SizedBox(height: 5),

        Container(
          decoration: BoxDecoration(
            color: theme == 'light' ? Colors.white : const Color(0xff1f2630),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: borderColor, width: 1) 
          ),
          child: Padding (
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              cursorColor: theme == 'light' ? Colors.black : Colors.white,
              controller: ctrler,
              style: TextStyle(
                color: theme == 'light' ? Colors.black : Colors.white
              ),
              inputFormatters: [
                CurrencyTextInputFormatter.currency(
                  symbol: '\$',
                  decimalDigits: 0,
                ),
              ],
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