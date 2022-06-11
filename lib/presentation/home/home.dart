import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_wallet/models/balance_model.dart';
import 'package:crypto_wallet/models/item_model.dart';
import 'package:crypto_wallet/presentation/global_widgets/custom_loading_widget.dart';
import 'package:crypto_wallet/presentation/home/bloc/home_cubit.dart';
import 'package:crypto_wallet/presentation/transaction_detail/transaction_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

      return const LoadingWidget();
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
          const SizedBox(height: 12),
          Expanded(
            child: SmartRefresher(
              controller: RefreshController(initialRefresh: false),
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: () => context.read<HomeCubit>().getBalance(),
              child: ListView.builder(
                itemCount: balanceModel.data!.items!.length,
                itemBuilder: (context, index) {
                  final model = balanceModel.data!.items![index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TransactionDetailPage(
                              id: balanceModel.data!.chainId.toString());
                        }));
                      },
                      child: BalanceItemListTile(model, context));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget BalanceItemListTile(Items item, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CachedNetworkImage(imageUrl: item.logoUrl!),
                    )),
                SizedBox(width: 8.0),
                Text(
                  item.contractTickerSymbol!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.balance!.toString(),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("﹩",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: Colors.grey[600])),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          item.quoteRate.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
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
          const SizedBox(height: 8),
          Text(balanceModel.data!.quoteCurrency! ?? '0',
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
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showMaterialBanner(MaterialBanner(
                            content: Container(
                              height: 50,
                              width: 50,
                              color: Colors.red,
                            ),
                            actions: [
                          Text("hello"),
                          GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .clearMaterialBanners();
                              },
                              child: Text("Close"))
                        ]));
                    // ScaffoldMessenger.of(context)
                    //   ..hideCurrentSnackBar
                    //   ..showSnackBar(SnackBar(
                    //       behavior: SnackBarBehavior.floating,
                    //       margin: EdgeInsets.zero,
                    //       elevation: 0,
                    //       // width: 200,
                    //       padding: EdgeInsets.zero,
                    //       backgroundColor: Colors.white,
                    //       content: Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 12, vertical: 12),
                    //         child: Container(
                    //           height: 100,
                    //           width: 200,
                    //           decoration: BoxDecoration(
                    //             color: Colors.green,
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               Text(
                    //                 "Copied",
                    //                 style: TextStyle(color: Colors.white),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       )));
                  },
                  child: const Icon(Icons.copy, color: Colors.white, size: 20))
            ],
          ),
        ],
      ),
    ),
  );
}
