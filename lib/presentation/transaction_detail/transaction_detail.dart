import 'package:flutter/material.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.9,
            child: Container(color: Colors.red),
          ),
        ],
      )),
    );
  }
}
