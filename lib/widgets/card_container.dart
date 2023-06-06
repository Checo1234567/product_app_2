import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        decoration: _cardContainerDecoration(),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  BoxDecoration _cardContainerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15,
          offset: Offset(0, 5),
        ),
      ],
    );
  }
}
