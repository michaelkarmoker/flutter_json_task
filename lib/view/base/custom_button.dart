import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function() onTap;
  const CustomButton({Key? key, required this.buttonText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(6))
        ),
        child: Text(buttonText,style: TextStyle(color: Colors.black,fontSize:18),),
      ),
    );
  }
}
