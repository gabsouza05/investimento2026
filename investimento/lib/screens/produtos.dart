import 'dart:math';
import 'package:flutter/material.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  double investimentoMensal = 0.0;
  double taxaJurosMensal = 0.0;
  int numeroMeses = 0;

  double semJuros() {
    return investimentoMensal * numeroMeses;
  }

  double comJuros() {
    if (taxaJurosMensal == 0) return semJuros();

    return investimentoMensal *
        ((pow(1 + taxaJurosMensal, numeroMeses) - 1) / taxaJurosMensal);
  }

  void resultado() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF6A040F),
        title: const Text(
          "Resultado",
          style: TextStyle(color: Color(0xFFFDC500)),
        ),
        content: Text(
          "Sem juros: R\$ ${semJuros().toStringAsFixed(2)}\n"
          "Com juros: R\$ ${comJuros().toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Fechar",
              style: TextStyle(color: Color(0xFFD90429)),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration campo(String texto) {
    return InputDecoration(
      hintText: texto,
      hintStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFD90429)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFFDC500), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A040F),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Simulador de Investimentos",
              style: TextStyle(
                fontSize: 26,
                color: Color(0xFFFDC500),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: campo("Investimento mensal"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                investimentoMensal = double.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: campo("Taxa de juros (%)"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                taxaJurosMensal = (double.tryParse(value) ?? 0) / 100;
              },
            ),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: campo("Número de meses"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                numeroMeses = int.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resultado,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD90429),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Simular"),
            ),
          ],
        ),
      ),
    );
  }
}
