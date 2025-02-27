import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculadoraScreen(),
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  double resultado = 0;
  TextEditingController controllerA = TextEditingController();
  TextEditingController controllerB = TextEditingController();
  String operacao = "soma";

  void calcular() {
    double a = double.tryParse(controllerA.text) ?? 0;
    double b = double.tryParse(controllerB.text) ?? 0;

    setState(() {
      if (operacao == "soma") {
        resultado = a + b;
      } else if (operacao == "subtracao") {
        resultado = a - b;
      } else if (operacao == "multiplicacao") {
        resultado = a * b;
      } else if (operacao == "divisao") {
        if (b != 0) {
          resultado = a / b;
        } else {
          resultado = double.nan; // Indica divisão por zero
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controllerA,
              decoration: InputDecoration(labelText: "Valor A"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: controllerB,
              decoration: InputDecoration(labelText: "Valor B"),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: operacao,
              onChanged: (String? novaOperacao) {
                setState(() {
                  operacao = novaOperacao!;
                });
              },
              items: ["soma", "subtracao", "multiplicacao", "divisao"]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: calcular,
              child: Text("Calcular"),
            ),
            Text(
              "Resultado: $resultado",
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}