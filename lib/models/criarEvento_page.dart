// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'master_2_page.dart';

class CriarEvento_Page extends StatefulWidget {
  const CriarEvento_Page({super.key});

  @override
  State<CriarEvento_Page> createState() => _CriarEvento_PageState();
}

class _CriarEvento_PageState extends State<CriarEvento_Page> {
  XFile? imagem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 173, 2),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 50, 133),
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          iconSize: 40,
          onPressed: () {},
        ),
        centerTitle: true,
        title: SizedBox(
          height: 48.0,
          child: Image.asset('assets/logo_uesb.png'),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(5.0),
              textStyle: const TextStyle(fontSize: 15),
            ),
            child: const Text('Voltar'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Master_2_Page()));
            },
          )
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
                style: TextStyle(color: Colors.black, fontSize: 20),
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
                      MaterialStateProperty.all<Color>(Colors.blue),
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
                child: const Text('Add Imagem'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            // CAMPOS DE TEXTO ------------------------------------------------
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Nome",
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
            const SizedBox(
              height: 10,
            ),

            // CURSO --------------------------------------------
            TextFormField(
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
            const SizedBox(
              height: 10,
            ),

            // Descrição ----------------------------------------------------
            TextFormField(
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
            const SizedBox(
              height: 30,
            ),

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
                        builder: (context) => const Master_2_Page()));
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
                    backgroundColor: const Color.fromARGB(255, 57, 50, 133),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(170.0, 50.0),
                    maximumSize: const Size(170.0, 50.0),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Criar Evento',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
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
}
