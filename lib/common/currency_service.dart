import 'dart:convert';
import 'package:http/http.dart' as http;

import 'currency_repo.dart';

Future<void> initCurrency() async {
  // Step 1: Get country code from ipapi
  final response = await http.get(Uri.parse("https://ipapi.co/json/"));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final countryCode = data["country"]; // e.g. "US", "IN"

    // Step 2: Fetch currency by country via GraphQL
    final currencyRepo = CurrencyRepo();
    final result = await currencyRepo.getCurrencyByCountry(countryCode);

    if (result != null) {
      final currency = result["currencyParams"];
      print("Currency: ${currency["code"]} ${currency["symbol"]}");
    }
  }
}
