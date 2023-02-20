import 'package:flutter/material.dart';

class BackHomeIconButton extends StatelessWidget {
  const BackHomeIconButton({super.key});

  @override
  Widget build(context) => IconButton(
        icon: const Icon(Icons.chevron_left, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pushNamed('/');
        },
      );
}
