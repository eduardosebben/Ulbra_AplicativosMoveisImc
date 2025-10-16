import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculoIMC(),
  ));
}

class CalculoIMC extends StatefulWidget {
  const CalculoIMC({Key? key}) : super(key: key);

  @override
  State<CalculoIMC> createState() => _CalculoIMCState();
}

class _CalculoIMCState extends State<CalculoIMC> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = "";

  void _calcularIMC() {
    final double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));
    final double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));

    if (peso == null || altura == null || altura == 0) {
      setState(() {
        _resultado = "Por favor, insira valores válidos.";
      });
      return;
    }

    final double imc = peso / (altura * altura);
    String classificacao = "";

    if (imc < 18.5) {
      classificacao = "Abaixo do peso";
    } else if (imc < 24.9) {
      classificacao = "Peso normal";
    } else if (imc < 29.9) {
      classificacao = "Sobrepeso";
    } else if (imc < 34.9) {
      classificacao = "Obesidade Grau I";
    } else if (imc < 39.9) {
      classificacao = "Obesidade Grau II";
    } else {
      classificacao = "Obesidade Grau III";
    }

    setState(() {
      _resultado = "IMC: ${imc.toStringAsFixed(2)}\n$classificacao";
    });
  }

  void _limparCampos() {
    setState(() {
      _pesoController.clear();
      _alturaController.clear();
      _resultado = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.monitor_weight_outlined, size: 96),
            const SizedBox(height: 12),
            TextField(
              controller: _pesoController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Peso (kg)",
                hintText: "Ex.: 72.5",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _alturaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Altura (m)",
                hintText: "Ex.: 1.75",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text("Calcular", style: TextStyle(fontSize: 18)),
              ),
            ),
            TextButton(
              onPressed: _limparCampos,
              child: const Text("Limpar campos"),
            ),
            const SizedBox(height: 12),
            Text(
              _resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
