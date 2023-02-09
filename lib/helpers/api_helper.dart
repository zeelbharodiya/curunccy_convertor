import 'dart:convert';

import 'package:http/http.dart' as http;

import '../views/screens/models/currency_convert.dart';





class APIHelper {
  // Singleton object
  APIHelper._();
  static final APIHelper apiHelper = APIHelper._();

  Future<Curency?> fetchRates({required String from , required String to , required int amount }) async {
    // String city = "surat";
    // String apiKey = "LW73JB84Hvwg7cEacg7nLKca1BY2kqC9cRl7Y8Bb";
    String api = "https://api.exchangerate.host/convert?from=USD&to=inr&amount=1";


    // https://api.exchangerate.host/convert?from=USD&to=inr&amount=1

    http.Response res = await http.get(Uri.parse(api));

    if(res.statusCode == 200) {
      Map decodedData = jsonDecode(res.body);

      //row data => customdata
      Curency currency = Curency.fromMap(data: decodedData);

      return currency;
    }
  }
}