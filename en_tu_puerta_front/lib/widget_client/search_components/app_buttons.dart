import 'package:flutter/material.dart';

class AppButtons extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String day;
  final String date;

  const AppButtons({
    super.key,
    required this.isSelected,
    required this.day,
    required this.onTap, 
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    String texto = "$day $date";
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 55,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Center(
          child: Text(texto, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
