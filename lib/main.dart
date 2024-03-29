import 'package:conversorteste2/service/api_client.dart';
import 'package:conversorteste2/widget/drop_down.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // API client
  ApiClient client = ApiClient();

  // Definições de cores
  Color firstcolor = Color(0xFF212936);
  Color segundcolor = Color(0xFF2849E5);

  // Variáveis config
  List<String> currencies = ['BRA'];
  String from = 'BRA'; // iniciando com qualquer moeda
  String to = 'US'; // iniciando com qualquer moeda

  // Variável para taxa.
  double rate = 0.0;
  String result = "";

  Future<List<String>> getCurrencyList() async {
    return await client.getCurrencies();
  }

  @override
  void initState() {
    super.initState();
    (() async {
      List<String> list = await getCurrencyList();
      setState(() {
        currencies = list;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // definição do texto(fonte/cor/alinhamento)
      backgroundColor: firstcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200.0,
                child: const Text(
                  "Conversor de Moeda",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // definindo os Text
                      TextField(
                        //função para a taxa
                        onSubmitted: (value) async {
                          rate = await client.getRate(from, to);
                          setState(() {
                            result =
                                (rate * double.parse(value)).toStringAsFixed(3);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Insira o valor",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18.0,
                            color: segundcolor,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        // posição de entrada de informação no field
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      //1º botão para escolha do pais
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customDropDown(currencies, from, (val) {
                            setState(() {
                              from = val!;
                            });
                          }),
                          // botão para alternar os paises
                          FloatingActionButton(
                            onPressed: () {
                              String temp = from;
                              setState(() {
                                from = to;
                                to = temp;
                              });
                            },
                            child: Icon(Icons.swap_horiz),
                            elevation: 0.0,
                            backgroundColor: segundcolor,
                          ),
                          //2º botão para escolha do pais
                          customDropDown(currencies, to, (val) {
                            setState(() {
                              to = val!;
                            });
                          }),
                        ],
                      ),
                      //Caixa onde irar aparecer o resultado
                      SizedBox(height: 50.0),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Column(
                          children: [
                            Text('Resultado',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(result),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
