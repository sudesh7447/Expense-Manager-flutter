import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  RoundedButton({
    required this.text,
    required this.press,
    required this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: () {
        press();
      },
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  TextFieldContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(0xFFF1E6FF),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator validator;
  // final ValueChanged<String> onChanged;
  RoundedInputField({
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.validator,
    // required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        // onChanged: onChanged,
        controller: controller,
        cursorColor: Color(0xFF6F35A5),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xFF6F35A5),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AddRoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final VoidCallback Val;
  // final ValueChanged<String> onChanged;
  AddRoundedInputField({
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.validator,
    required this.Val,

    // required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onTap: () {
          Val();
        },
        // onChanged: onChanged,
        controller: controller,

        cursorColor: Color(0xFF6F35A5),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xFF6F35A5),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AmountRoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator validator;
  // final ValueChanged<String> onChanged;
  AmountRoundedInputField({
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.validator,
    // required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        // onChanged: onChanged,
        keyboardType: TextInputType.number,
        controller: controller,
        cursorColor: Color(0xFF6F35A5),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xFF6F35A5),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
