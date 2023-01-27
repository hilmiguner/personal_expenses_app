import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AdaptiveTextButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: Text(text,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: Theme.of(context).textTheme.headline1.fontFamily,
                  fontSize: Theme.of(context).textTheme.headline1.fontSize,
                  fontWeight: FontWeight.bold,
                )),
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(text,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: Theme.of(context).textTheme.headline1.fontFamily,
                  fontSize: Theme.of(context).textTheme.headline1.fontSize,
                  fontWeight: FontWeight.bold,
                )),
          );
  }
}
