// ignore_for_file: file_names, avoid_print, unused_local_variable, prefer_const_constructors, prefer_final_fields, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Comunicação síncrona = instantânea como numa conversa entre duas pessoas. 
  //Assíncrona é como quando se manda uma msg e a outra pessoa leva um tempo para responder.

  String cep = '';
  String logradouro = '';
  String complemento = '';
  String bairro = '';
  String localidade = '';
  String uf = '';

  TextEditingController _controllercepInserido = TextEditingController();

  _recuperarCep() async {
    
    var _cepInserido = _controllercepInserido.text;

    String url = 'https://viacep.com.br/ws/$_cepInserido/json/';

    print(url.toString());
    
    http.Response response;

    response = await http.get(Uri.parse(url));

    print('Resposta: ${response.statusCode}' );
    print('Resposta: ${response.body}' );

    Map retorno = jsonDecode(response.body);

    print('CEP: $cep');
    print('Logradouro: $logradouro');
    print('Complemento: $complemento');
    print('Bairro: $bairro');
    print('Localidade: $localidade');
    print('UF: $uf');

    setState(() {
    cep = retorno['cep'];
    logradouro = retorno['logradouro'];
    complemento = retorno['complemento'];
    bairro = retorno['bairro'];
    localidade = retorno['localidade'];
    uf = retorno['uf'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de serviço web'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,  
          crossAxisAlignment: CrossAxisAlignment.center,      
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Insira o CEP'
              ),
              controller: _controllercepInserido ,
            ),
            Padding(
              padding: const EdgeInsets.only(top:20),
              child: ElevatedButton(
                onPressed: _recuperarCep, 
                child: const Text('Clique aqui')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('CEP: $cep'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('Logradouro: $logradouro'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('Complemento: $complemento'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('Bairro: $bairro'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('Localidade: $localidade')),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text('UF: $uf'),
            ),
          ],
        ),
      ),
    );
  }
}