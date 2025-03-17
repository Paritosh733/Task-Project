import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSize {
  static const s = 12.0;
  static const regular = 14.0;
  static const title = 16.0;
  static const xl = 18.0;
}

Widget cText(String text,
    {double fontSize = 14,
    color = Colors.black,
    FontWeight? weight,
    TextOverflow? overflow,
    TextAlign? textAlign}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: weight,
      overflow: overflow,
    ),
  );
}

Widget title(String title) {
  return Text(title,
      style: const TextStyle(
          fontSize: TextSize.title, fontWeight: FontWeight.bold));
}

Widget commonButton(String buttonText, final voidCallback,
    {bool canPressbtn = true}) {
  return Container(
    height: 35,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        // foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
            //to set border radius to button
            borderRadius: BorderRadius.circular(12)), // foreground (text) color
      ),
      onPressed: () {
        voidCallback();
      },
      child: Center(
        child: canPressbtn
            ? Text(
                buttonText,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white),
              )
            : Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
      ),
    ),
  );
}

Widget commonIconButton(icon, final voidCallback, bool edit) {
  return InkWell(
    onTap: () {
      voidCallback();
    },
    child: Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: (icon == Icons.delete) ? Colors.redAccent : Colors.blueAccent),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 14,
        ),
      ),
    ),
  );
}

Widget textFormField(
  TextEditingController textController,
  String hintText, {
  String validate = "Required Field *",
  bool showValidate = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 50,
        margin: EdgeInsets.only(
          bottom: 10,
          top: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: (10.0)),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                // validator: (value){
                //   if(value == null || value.isEmpty) {
                //     return "Field Required";
                //   }
                // },
                controller: textController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  contentPadding: const EdgeInsets.only(top: 5, bottom: 5),
                  // prefixIcon: Icon(Icons.email_outlined,size: 18,),
                ),
              ),
            ),
          ],
        ),
      ),
      if (showValidate)
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 5),
          child: cText(validate,
              color: Colors.red.withOpacity(.8), fontSize: TextSize.regular),
        ),
    ],
  );
}
