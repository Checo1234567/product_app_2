import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          const HeaderIcon(),
          this.child,
        ],
      ),
    );
  }
}

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        width: double.infinity,
        child: const Icon(Icons.person_pin, color: Colors.white, size: 100.0),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: deviceSize.height * 0.4,
      decoration: _boxDecorationPurpleBox(),
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: _Bubble()),
          Positioned(top: -40, left: -30, child: _Bubble()),
          Positioned(top: -50, right: -20, child: _Bubble()),
          Positioned(bottom: -50, left: 10, child: _Bubble()),
          Positioned(bottom: 120, right: 20, child: _Bubble()),
        ],
      ),
    );
  }

  BoxDecoration _boxDecorationPurpleBox() {
    return const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 170, 1),
          ],
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(14), bottomRight: Radius.circular(14)));
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
