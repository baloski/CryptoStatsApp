import 'package:cryptostats/widgets/CryptoListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Cryptocurrency.dart';
import '../providers/market_provider.dart';
import '../pages/DetailPage.dart';


class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, MarketProvider, child) {
        if (MarketProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (MarketProvider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await MarketProvider.fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: MarketProvider.markets.length,
                itemBuilder: (context, index) {
                  CryptoCurrency currentCrypto = MarketProvider.markets[index];

                  return CryptoListTile(currentCrypto: currentCrypto);
                },
              ),
            );
          } else {
            return const Text("Data Not Found!");
          }
        }
      },
    );
  }
}