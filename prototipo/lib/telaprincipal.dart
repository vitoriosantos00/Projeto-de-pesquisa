import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  UserAccelerometerEvent? _useraccelerometerevent;

  StreamSubscription<UserAccelerometerEvent>? _streamsubscriptionaccelerometer;

  Position? posicaoatual;

  @override
  void initState() {
    super.initState();
    _streamsubscriptionaccelerometer =
        userAccelerometerEventStream().listen((event) {
      setState(() {
        _useraccelerometerevent = event;
      });
    });
    mostrarLocaliza();
  }

  @override
  void dispose() {
    _streamsubscriptionaccelerometer?.cancel();
    super.dispose();
  }

  mostrarLocaliza() async {
    bool localizacaoativada;
    LocationPermission permissao;
    localizacaoativada = await Geolocator.isLocationServiceEnabled();
    if (!localizacaoativada) {
      Future.error('Localização está desabilitada');
    }
    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        Future.error(
            'Permissão negada, abra as configurações e altere as configurações de permissão');
      }
    }
    if (permissao == LocationPermission.deniedForever) {
      Future.error('A permissão está negada sempre, precisamos da permissão.');
    }
    Geolocator.getPositionStream().listen((Position posicao) {
      setState(() {
        posicaoatual = posicao;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      appBar: AppBar(
        title: SafeArea(
          child: Text('Prototipo'),
        ),
        elevation: 5.0,
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Column(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('imagens/photo.jpeg'),
                ),
                Text('Antônio Vitorio Silva dos Santos'),
                Text('vitoriosantos00@gmail.com'),
              ],
            )),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          _buildMostrarDadosAcelerometro(),
          SizedBox(
            height: 30.0,
          ),
          _buildMostrarDadosLoc()
        ]),
      ),
    );
  }

  Widget _buildMostrarDadosAcelerometro() {
    return Card(
      child: Column(
        children: <Widget>[
          Text('Testar Localização'),
          Text(
              'Latitude: ${posicaoatual?.latitude.toStringAsFixed(6)}, Longitude ${posicaoatual?.longitude.toStringAsFixed(6)}'),
        ],
      ),
    );
  }

  Widget _buildMostrarDadosLoc() {
    return Card(
      child: Column(
        children: <Widget>[
          Text('Testar Acelerometro'),
          Text(
              'x: ${_useraccelerometerevent?.x?.toStringAsFixed(4) ?? 'N/A'} y: ${_useraccelerometerevent?.y?.toStringAsFixed(4) ?? 'N/A'} z: ${_useraccelerometerevent?.z?.toStringAsFixed(4) ?? 'N/A'}'),
        ],
      ),
    );
  }
}
