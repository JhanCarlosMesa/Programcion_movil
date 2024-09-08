import 'package:flutter/material.dart';
import 'cuadro_magico.dart';

void main() {
  runApp(CuadroMagicoApp());
}

class CuadroMagicoApp extends StatelessWidget {
  @override
  Widget build(BuildContext contexto) {
    return MaterialApp(
      title: 'Cuadro Mágico',
      home: cuadradoMagico(),
    );
  }
}
