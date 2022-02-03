import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(5)),
      child: const Padding(
        padding: EdgeInsets.all(17.0),
        child: CircularProgressIndicator(
          color: Colors.white70,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
