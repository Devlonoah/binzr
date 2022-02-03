import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String id = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: HomepageBody()));
  }
}

class HomepageBody extends StatelessWidget {
  const HomepageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          balanceCard(context),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
                children: List.generate(
                    12,
                    (index) => ListTile(
                          leading: FlutterLogo(),
                          title: Text(
                            'AVINOC',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('\$10.0'),
                                Text('0.02'),
                              ]),
                        ))),
          )
        ],
      ),
    );
  }

  Container balanceCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 45),
      decoration: BoxDecoration(
          color: const Color(0xFF000000),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Balance:',
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('Eth',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('0.075',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Divider(
              color: Colors.white,
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
