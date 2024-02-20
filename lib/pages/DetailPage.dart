import 'package:cryptostats/models/Cryptocurrency.dart';
import 'package:cryptostats/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import "package:syncfusion_flutter_charts/charts.dart";

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({super.key, required this.id});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          detail,
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(

        appBar: AppBar(

        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView(

              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                ),
                const SizedBox(
                  height: 10,
                ),

                Consumer<MarketProvider>(
                  builder: (context, marketProvider, child) {
                    CryptoCurrency currentCrypto =
                    marketProvider.fetchCryptoById(widget.id);

                    return ListView(


                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          contentPadding: const EdgeInsets.all(10),
                          tileColor: const Color.fromARGB(19, 92, 92, 92),


                          leading: (
                              ClipOval(
                                child: Image.network(currentCrypto.image!),


                              )
                          ),
                          title: Text(
                            "${currentCrypto.name!} (${currentCrypto.symbol!.toUpperCase()})",
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          subtitle: Text(
                            "₹ ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
                            style: const TextStyle(
                                color: Color(0xff0395eb),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price Change (24h)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20 ,),
                            ),
                            Builder(
                              builder: (context) {
                                double priceChange =
                                currentCrypto.priceChange24!;
                                double priceChangePercentage =
                                currentCrypto.priceChangePercentage24!;

                                if (priceChange < 0) {
                                  // negative
                                  return Text(
                                    "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 23),
                                  );
                                } else {
                                  // positive
                                  return Text(
                                    "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 23),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "Market Cap",
                                "₹ ${currentCrypto.marketCap!.toStringAsFixed(4)}",
                                CrossAxisAlignment.start),
                            titleAndDetail(
                                "Market Cap Rank",
                                "#${currentCrypto.marketCapRank}",
                                CrossAxisAlignment.end),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "Low 24h",
                                "₹ ${currentCrypto.low24!.toStringAsFixed(4)}",
                                CrossAxisAlignment.start),
                            titleAndDetail(
                                "High 24h",
                                "₹ ${currentCrypto.high24!.toStringAsFixed(4)}",
                                CrossAxisAlignment.end),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "Circulating Supply",
                                currentCrypto.circulatingSupply!
                                    .toInt()
                                    .toString(),
                                CrossAxisAlignment.start),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "All Time Low",
                                currentCrypto.atl!.toStringAsFixed(4),
                                CrossAxisAlignment.start),
                            titleAndDetail(
                                "All Time High",
                                currentCrypto.ath!.toStringAsFixed(4),
                                CrossAxisAlignment.start),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}