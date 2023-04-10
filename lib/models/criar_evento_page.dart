// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uesbvent/models/organizador_page.dart';
import 'package:uesbvent/models/usuario.dart';

import 'evento.dart';

class CriarEventoPage extends StatefulWidget {
  const CriarEventoPage({super.key});

  @override
  State<CriarEventoPage> createState() => _CriarEventoPageState();
}

class _CriarEventoPageState extends State<CriarEventoPage> {
  final firebaseAuth = FirebaseAuth.instance;
  final controllerTitle = TextEditingController();
  final controllerDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        color: Colors.indigo,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/logo_uesb.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Dados do Evento',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            SizedBox(height: 20),

            TextFormField(
              controller: controllerTitle,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Título do Evento",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  )),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 10),

            TextFormField(
              controller: controllerDescricao,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Descrição",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  )),
              minLines: 5,
              maxLines: 10,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //BOTÃO CRIAR -------------------------------------------
            Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(110, 20, 110, 40),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  )),
              child: SizedBox.expand(
                child: TextButton(
                  child: const Text(
                    "Criar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    if (controllerTitle.text.isNotEmpty &&
                        controllerDescricao.text.isNotEmpty) {
                      final evento = Evento(
                        title: controllerTitle.text,
                        descricao: controllerDescricao.text,
                      );

                      criarEvento(evento);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.warning_outlined,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Text('   '),
                              Text('Preencha todos os campos obrigatórios!'),
                            ],
                          ),
                          height: 60.0,
                        ),
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future criarEvento(Evento evento) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('eventos').doc();

      evento.id = docUser.id;

      final json = evento.toJson();
      await docUser.set(json);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
                Text('   '),
                Text('Evento criado com sucesso!'),
              ],
            ),
            height: 60.0,
          ),
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OrganizadorPage()));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OrganizadorPage()),
          (route) => false);

      //Cria o usuário no Banco

      //--------
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
                Text('   '),
                Text('Dados inválidos!'),
              ],
            ),
            height: 60.0,
          ),
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
