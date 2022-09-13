import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  const CustomButton({Key? key, required this.buttonColor, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle font = new TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        height: size.height * 0.08 ,
        width: size.width * 0.8,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 5.0,),
              blurRadius: 4.0,
            ), //BoxShadow
          ],
        ),
        child: Text(buttonText,style: font,textAlign: TextAlign.center,),
      ),

    );
  }
}
