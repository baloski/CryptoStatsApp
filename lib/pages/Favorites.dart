import 'package:cryptostats/models/Cryptocurrency.dart';
import 'package:cryptostats/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/CryptoListTile.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoCurrency> favorites = marketProvider.markets
            .where((element) => element.isFavorite == true)
            .toList();
        if (favorites.isNotEmpty) {
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              CryptoCurrency currentCrypto = favorites[index];
              return CryptoListTile(currentCrypto: currentCrypto);
            },
          );
        }
        else{
          return const Center(child: Text("No Favorites yet",style: TextStyle(color:Colors.grey,fontSize: 25),),);

        }
      },
    );

  }
}