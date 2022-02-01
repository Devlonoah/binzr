import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String id = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomepageBody());
  }
}

class HomepageBody extends StatelessWidget {
  const HomepageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: Colors.black,
        )
      ],
    );
  }
}
