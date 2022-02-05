import 'package:crypto_wallet/models/balance_model.dart';
import 'package:crypto_wallet/models/item_model.dart';
import 'package:crypto_wallet/presentation/global_widgets/custom_loading_widget.dart';
import 'package:crypto_wallet/presentation/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static String id = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().getBalance();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: HomepageBody()),
    );
  }
}

class HomepageBody extends StatelessWidget {
  const HomepageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeLoaded) {
        return LoadedWidget(balanceModel: state.balanceModel);
      }

      if (state is HomeFailed) {
        return const FailureWidget();
      }

      return LoadingWidget();
    });
  }
}

class FailureWidget extends StatelessWidget {
  const FailureWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Error occured'));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CustomLoadingWidget());
  }
}

class LoadedWidget extends StatelessWidget {
  const LoadedWidget({Key? key, required this.balanceModel}) : super(key: key);

  final BalanceModel balanceModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          balanceCard(context, balanceModel: balanceModel),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: balanceModel.data!.items!.length,
              itemBuilder: (context, index) {
                final model = balanceModel.data!.items![index];
                return BalanceItemListTile(model, context);
              },
            ),
          )
        ],
      ),
    );
  }

  ListTile BalanceItemListTile(Items item, BuildContext context) {
    return ListTile(
      tileColor: Colors.grey[200],
      onTap: () {
        print('hello');
      },
      leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.network(item.logoUrl!),
          )),
      title: Text(
        item.contractName!,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.quote!.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.grey[800]),
            ),
            Text(
              item.quoteRate.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.grey[600]),
            ),
          ]),
    );
  }
}

Container balanceCard(BuildContext context,
    {required BalanceModel balanceModel}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 45),
    decoration: BoxDecoration(
        color: const Color(0xFF000000),
        borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
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
          Text(balanceModel.data!.quoteCurrency! ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(balanceModel.data!.address!.substring(0, 8) + "xxxxxxxxxxxx",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Colors.grey[400], fontWeight: FontWeight.bold)),
              SizedBox(width: 20),
              const Icon(Icons.copy, color: Colors.white, size: 20)
            ],
          ),
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
    ),
  );
}
