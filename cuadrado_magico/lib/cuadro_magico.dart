import 'package:flutter/material.dart';

class cuadradoMagico extends StatefulWidget {
  @override
  Estado_del_cuadro createState() => Estado_del_cuadro();
}

//Logica para el cuadro magico
class Estado_del_cuadro extends State<cuadradoMagico> {
  final List<TextEditingController> controladores = List.generate(9, (_) => TextEditingController());
  String mensaje = '';

//Eliminar controladores para liberar espacio
  @override
  void dispose() {
    for (var controlador in controladores) {
      controlador.dispose();
    }
    super.dispose();
  }

//Validacion del cuadro magico
  void validarCuadroMagico() {
    List<int> valores = controladores.map((controlador) => int.tryParse(controlador.text) ?? 0).toList();
    if (valores.length != 9 || valores.any((valor) => valor < 1 || valor > 9) || valores.toSet().length != 9) {
      setState(() {
        mensaje = 'Valor digitado incorrecto, por favor solo poner números del 1 al 9 (sin repetir)';
      }); //comprueba si con numeros del 1 al 9, que no se repitan
      return;
    }

    int suma = valores[0] + valores[1] + valores[2];
    bool comprobar = 
      (valores[3] + valores[4] + valores[5] == suma) &&
      (valores[6] + valores[7] + valores[8] == suma) &&
      (valores[0] + valores[3] + valores[6] == suma) &&
      (valores[1] + valores[4] + valores[7] == suma) &&
      (valores[2] + valores[5] + valores[8] == suma) &&
      (valores[0] + valores[4] + valores[8] == suma) &&
      (valores[2] + valores[4] + valores[6] == suma);

    setState(() {
      mensaje = comprobar ? 'Este SI es un cuadrado mágico' : 'Este NO es un cuadrado mágico.';
    }); //comprueba las sumas
  }

  //interfaz grafica
  @override
  Widget build(BuildContext contexto) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CUADRADO MÁGICO', style: TextStyle(color: const Color.fromARGB(255, 96, 7, 112), fontWeight: FontWeight.bold) 
      ),
      backgroundColor: Colors.lightBlue[100], centerTitle: true,
      ),
      backgroundColor: Colors.lightBlue[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: 9,
              itemBuilder: (contexto, indice) {
                return TextField(
                  controller: controladores[indice],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: const Color.fromARGB(255, 96, 7, 112))),
                  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: validarCuadroMagico,
              child: Text('Comprobar cuadro mágico', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            Text(
              mensaje,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
