import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(consultaTemperatura());
}

class consultaTemperatura extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CONSULTAR TEMPERATURA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: mostrarTemperatura(),
    );
  }
}

class mostrarTemperatura extends StatefulWidget {
  @override
  _PantallaTemperaturaState createState() => _PantallaTemperaturaState();
}

class _PantallaTemperaturaState extends State<mostrarTemperatura> {
  final TextEditingController _controladorLatitud = TextEditingController();
  final TextEditingController _controladorLongitud = TextEditingController();
  String _temperatura = '';

  Future<void> obtenerTemperatura(double latitud, double longitud) async {
    try {
      final respuesta = await http.get(
        Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&current=temperature'),
      );

      if (respuesta.statusCode == 200) {
        final datos = json.decode(respuesta.body);
        final temperaturaActual = datos['current']['temperature'];
        setState(() {
          _temperatura = '$temperaturaActual °C';
        });
      } else {
        setState(() {
          _temperatura = 'Error al buscar temperatura';
        });
      }
    } catch (e) {
      setState(() {
        _temperatura = '17 °C (Esta es una temperatura predeterminada)';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Center(
          child: Text(
            'Consultar Temperatura',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        color: Colors.blue[100],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _controladorLatitud,
                  keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: InputDecoration(
                    labelText: 'Latitud',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[300],
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _controladorLongitud,
                  keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: InputDecoration(
                    labelText: 'Longitud',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[300],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final latitud = double.tryParse(_controladorLatitud.text);
                    final longitud = double.tryParse(_controladorLongitud.text);

                    if (latitud != null && longitud != null) {
                      obtenerTemperatura(latitud, longitud);
                    } else {
                      setState(() {
                        _temperatura = 'Coordenadas invalidas';
                      });
                    }
                  },
                  child: Text('Consultar Temperatura'),
                ),
                SizedBox(height: 20),
                Text(
                  _temperatura.isEmpty
                      ? 'Ingresa las coordenadas para ver la temperatura actual'
                      : 'Temperatura: $_temperatura',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Text(
                  'Desarrollo: Jhan Carlos Mesa Escobar',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
