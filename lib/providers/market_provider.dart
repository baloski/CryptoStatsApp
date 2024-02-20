import 'dart:async';
import 'package:cryptostats/models/API.dart';
import 'package:cryptostats/models/Cryptocurrency.dart';
import 'package:cryptostats/models/LocalStorage.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<dynamic>? fetchedMarkets = await API.getMarkets();
      if (fetchedMarkets != null) {
        List<String> favorites = await LocalStorage.fetchFavorites();

        List<CryptoCurrency> temp = [];
        for (var market in fetchedMarkets) {
          CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
          if (favorites.contains(newCrypto.id!)) {
            newCrypto.isFavorite = true;
          }
          temp.add(newCrypto);
        }
        markets = temp;
        isLoading = false;
        notifyListeners();
      } else {
        // Handle case where markets data is null or empty
        print("Failed to fetch markets data");
        // Optionally, you can set isLoading to false and notifyListeners()
        // to trigger UI update indicating that data fetching has finished.
        isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      // Handle any errors that occur during data fetching
      print("Error fetching markets data: $error");
      // Optionally, you can set isLoading to false and notifyListeners()
      // to trigger UI update indicating that data fetching has finished.
      isLoading = false;
      notifyListeners();
    }
  }


  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
    markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removeFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}