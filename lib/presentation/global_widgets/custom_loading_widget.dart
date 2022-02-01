import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(5)),
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
