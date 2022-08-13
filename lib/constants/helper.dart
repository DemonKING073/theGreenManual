import 'package:flutter/material.dart';

import 'constant.dart';

class Button extends StatelessWidget {
  String? name;
  Function onTap;
  Button({this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              colors: [primaryColor, Color(0xff7ACCA9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        width: double.infinity,
        child: Center(
            child: Text(
          name!,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        )),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}

class WhiteButton extends StatelessWidget {
  String? name;
  Function onTap;
  String? image;
  WhiteButton({this.name, required this.onTap , this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        width: double.infinity,
        child: Row(
          children: [
        SizedBox(width: MediaQuery.of(context).size.width*0.15,),

        Image.asset(image!, height: 25, width: 25),
        SizedBox(width: 15,),
        Text(
          name!,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}

class WhiteButtonNoLogo extends StatelessWidget {
  String name;
  Function onTap;
  WhiteButtonNoLogo({required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffEEEEEE)
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }
}
