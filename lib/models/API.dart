import 'package:http/http.dart' as http;
import 'dart:convert';


class API {
  static Future<List<dynamic>?> getMarkets() async {
    try {
      Uri requestPath = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en");
      var response = await http.get(requestPath);

      if (response.statusCode == 200) {
        var decodeResponse = jsonDecode(response.body);
        List<dynamic> markets = decodeResponse as List<dynamic>;
        return markets;
      } else {
        print("API request failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (ex) {
      print("Error fetching markets: $ex");
      return null;
    }
  }
}