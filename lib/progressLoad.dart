import 'package:flutter/material.dart';
import 'package:proyectocamion/loginscreen.dart';


class ProgressLoad extends StatelessWidget
{
  String message;
  ProgressLoad(this.message);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.green,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding:  EdgeInsets.all(15.0),
          child:  Row(
            children: [
              SizedBox(width: 6.0,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
              SizedBox(width: 26.0,),
              Text(
                message,
                style: TextStyle(color: Colors.black, fontSize: 10.0,
                fontFamily: "Brand-Bold"),
              )
            ],
          ),
        ),
      ),
    );

  }
}