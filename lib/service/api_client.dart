import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final Uri currencyURL = Uri.https('api.frankfurter.app', '/latest');
  // retornado sigla
  Future<List<String>> getCurrencies() async {
    http.Response res = await http.get(currencyURL);
    //verificando conexao
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body['rates'];
      List<String> currencies = (list.keys).toList();
      print(currencies); // verificar se api retornou os valores, apagar dps.
      return currencies;
    } else {
      throw Exception("Erro ao conectar a API");
    }
  }

  //retornado a taxa de cambio da moeda (from) em comparação com (to)
  Future<double> getRate(String from, String to) async {
    final String apiUrl =
        'https://api.frankfurter.app/latest?from=$from&to=$to';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> rates = data['rates'];

      final double currencies = rates[to];

      return currencies;
    } else {
      throw Exception('Erro de conexão');
    }
  }
}
