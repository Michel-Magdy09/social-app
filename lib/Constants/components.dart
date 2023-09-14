import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.text,
      required this.keyBoardType,
      required this.prefixIcon,
      required this.validate,
      this.onTap,
      this.suffixIcon,
      this.isPasswordSeen = false});
  String? Function(String?)? validate;
  String hintText;
  var keyBoardType;
  var prefixIcon;
  TextEditingController text;
  var suffixIcon;
  VoidCallback? onTap;
  bool isPasswordSeen;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordSeen,
      validator: validate,
      controller: text,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      keyboardType: keyBoardType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          errorStyle: const TextStyle(
              fontSize: 16.0, color: Colors.red, fontWeight: FontWeight.bold),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.black,
            size: 20,
          ),
          suffixIcon: InkWell(
            onTap: onTap,
            child: Icon(suffixIcon),
          ),
          labelText: hintText,
          labelStyle: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.titleText,
      required this.buttonColor,
      required this.textColor,
      required this.pressed});

  String titleText;
  var buttonColor;
  var textColor;
  VoidCallback pressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: ElevatedButton(
        onPressed: pressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: buttonColor,
        ),
        child: Text(
          titleText,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// class chatBubble extends StatelessWidget {
//   const chatBubble({
//     required this.message,
//     super.key,
//   });
//
//   final Message message;
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         padding:
//             const EdgeInsets.only(left: 10, top: 16, right: 32, bottom: 16),
//         margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//         decoration: const BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(30),
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Text(message.message),
//       ),
//     );
//   }
// }
//
// class chatBubbleWithFriend extends StatelessWidget {
//   const chatBubbleWithFriend({
//     required this.message,
//     super.key,
//   });
//
//   final Message message;
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         padding:
//             const EdgeInsets.only(left: 10, top: 16, right: 32, bottom: 16),
//         margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//         decoration: const BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(30),
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Text(message.message),
//       ),
//     );
//   }
// }
