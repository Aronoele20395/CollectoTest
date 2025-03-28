import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final double amount;
  final String label;
  
  const PriceWidget({
    super.key, 
    required this.amount, 
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${amount.toStringAsFixed(2)}€', //Pre mostrare la seconda cifra decimale anche se 0
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFA98A68),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}