import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  const CustomRaisedButton({
    Key key,
    this.color,
    this.borderRadius: 4.0,
    this.height: 50.0,
    this.onPressed,
    this.child,
  })  : assert(borderRadius != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        color: color,
        disabledColor: color,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
