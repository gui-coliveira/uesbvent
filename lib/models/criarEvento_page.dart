// ignore: file_names
// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uesbvent/models/evento.dart';
import 'package:uesbvent/models/organizador_page.dart';

import 'package:uesbvent/models/login_page.dart';

class CriarEvento_Page extends StatefulWidget {
  const CriarEvento_Page({super.key});

  @override
  State<CriarEvento_Page> createState() => _CriarEvento_PageState();
}

class _CriarEvento_PageState extends State<CriarEvento_Page> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  final controllerTitle = TextEditingController();
  final controllerDescricao = TextEditingController();
  final controllerCurso = TextEditingController();
  XFile? imagem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: SizedBox(
          height: 48.0,
          child: Image.asset('assets/logo_universidade.png'),
        ),
        actions: <Widget>[
          TextButton(
            child: currentUser?.email != null ? Text('Sair') : Text('Login'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (currentUser?.email != null) {
                signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Novo Evento',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            // Container para guardar a imagem do evento ------------------------
            Container(
                width: 270,
                height: 170,
                color: Colors.white,
                //alignment: const Alignment(0.0, 1.15),
                child: imagem != null
                    ? Image.file(
                        File(imagem!.path),
                        fit: BoxFit.fitWidth,
                      )
                    : null),

            // BOTÃO PARA ADICIONAR IMAGEM -------------------------------------
            Container(
              height: 35,
              alignment: Alignment.topLeft,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.orangeAccent),
                ),
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();

                  try {
                    XFile? file =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (file != null) setState(() => imagem = file);
                  } on Exception catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Adicionar Imagem'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            // CAMPOS DE TEXTO ------------------------------------------------
            TextFormField(
              controller: controllerTitle,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Título do Evento",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 104, 104, 104),
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 10),

            // Curso --------------------------------------------
            TextFormField(
              controller: controllerCurso,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Curso",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 104, 104, 104),
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 10),

            // Descrição ----------------------------------------------------
            TextFormField(
              controller: controllerDescricao,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Descrição",
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 104, 104, 104),
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              maxLines: null,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 30),

            // BOTÃO CANCELAR -------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 145, 145, 145),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(170.0, 50.0),
                    maximumSize: const Size(170.0, 50.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OrganizadorPage()));
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),

                //BOTÃO CRIAR EVENTO -------------------------------------
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(170.0, 50.0),
                    maximumSize: const Size(170.0, 50.0),
                  ),
                  child: const Text(
                    'Criar Evento',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    if (controllerTitle.text.isNotEmpty &&
                        controllerDescricao.text.isNotEmpty) {
                      final evento = Evento(
                        title: controllerTitle.text,
                        descricao: controllerDescricao.text,
                        //curso: controllerCurso.text,
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
              ],
            ),

            const SizedBox(
              height: 30,
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
      //----------------
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

  Future<void> signOut() async {
    print('Sign Out');
    await FirebaseAuth.instance.signOut();
  }
}
