import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final String theme;
  final Function toggleTheme;
  const ThemeButton({
    super.key,
    required this.theme,
    required this.toggleTheme
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: theme == 'light' ? Colors.white : const Color(0xff1f2630),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                theme == 'dark' ? 'Dark Theme' : 'Light Theme', 
              )
            ],
          ),
          CupertinoSwitch(
            value: theme == 'dark' ? true : false, 
            activeColor: const Color(0xfffbc700),
            onChanged: (value) {
              toggleTheme();
            }
          )
        ],
      ),
    );
  }
}