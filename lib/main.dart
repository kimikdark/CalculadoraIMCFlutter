import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ImcCalculator(),
  ));
}

class ImcCalculator extends StatefulWidget {
  const ImcCalculator({super.key});

  @override
  State<ImcCalculator> createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  String _resultado = '';
  Color _corResultado = Colors.black; // Cor inicial para o texto de resultado

  void _calcularImc() {
    double? peso = double.tryParse(_pesoController.text);
    double? altura = double.tryParse(_alturaController.text);

    if (peso == null || altura == null || altura <= 0) {
      setState(() {
        _resultado = 'Insere valores válidos.';
        _corResultado = Colors.red;
      });
      return;
    }

    double imc = peso / (altura * altura);
    String classificacao;
    Color cor;

    if (imc < 18.5) {
      classificacao = 'Abaixo do peso';
      cor = Colors.orangeAccent;
    } else if (imc < 24.9) {
      classificacao = 'Peso normal';
      cor = Colors.teal;
    } else if (imc < 29.9) {
      classificacao = 'Sobrepeso';
      cor = Colors.orange;
    } else {
      classificacao = 'Obesidade';
      cor = Colors.red;
    }

    setState(() {
      _resultado = 'IMC: ${imc.toStringAsFixed(2)}\n$classificacao';
      _corResultado = cor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true, // Centraliza o título
        backgroundColor: Colors.teal, // Nova cor da barra
        elevation: 0, // Remove a sombra para um look mais limpo
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView( // Permite a rolagem se o teclado aparecer
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.monitor_weight, size: 80, color: Colors.teal), // Adiciona um ícone grande
              const SizedBox(height: 20),
              const Text(
                'Calculadora de IMC',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _pesoController,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.fitness_center, color: Colors.teal), // Cor do ícone
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _alturaController,
                decoration: InputDecoration(
                  labelText: 'Altura (m)',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.height, color: Colors.teal), // Cor do ícone
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _calcularImc,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Cor do botão consistente
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 5, // Elevação para o botão
                ),
                child: const Text(
                  'Calcular IMC',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                _resultado,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _corResultado),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}