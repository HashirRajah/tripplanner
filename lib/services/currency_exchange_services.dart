import 'dart:convert';
import 'package:http/http.dart';
import 'package:tripplanner/shared/constants/api_keys.dart';

class CurrencyExchangeService {
  final String apiKey = currencyExchangeAPIKey;
  final String authority = 'v6.exchangerate-api.com';
  //
  Future<double?> getExchangeRate(
    String baseCurrency,
    String targetCurrency,
    double amount,
  ) async {
    final String unencodedpath =
        'v6/$currencyExchangeAPIKey/pair/$baseCurrency/$targetCurrency/$amount';
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
    );
    //
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //
      if (data['result'] == 'success') {
        double resultantAmount = data['conversion_result'];
        //
        return resultantAmount;
      } else if (data['result'] == 'error') {
        return null;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  //
  Future<double?> getConvertionRate(
    String baseCurrency,
    String targetCurrency,
  ) async {
    final String unencodedpath =
        'v6/$currencyExchangeAPIKey/pair/$baseCurrency/$targetCurrency';
    //
    Uri url = Uri.https(
      authority,
      unencodedpath,
    );
    //
    try {
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      //
      if (data['result'] == 'success') {
        double rate = data['conversion_rate'];
        //
        return rate;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
