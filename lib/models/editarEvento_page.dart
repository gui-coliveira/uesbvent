import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uesbvent/models/codSeguranca_page.dart';
import 'package:uesbvent/models/eventosInscritos_page.dart';
import 'package:uesbvent/models/home_page.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:uesbvent/models/organizador_page.dart';
import 'package:uesbvent/models/recover_page.dart';
import 'package:uesbvent/models/usuario.dart';
import 'package:uesbvent/models/validarcertificado_page.dart';

import 'evento.dart';

class EditarEventoPage extends StatefulWidget {
  final Evento evento;
  EditarEventoPage(this.evento);

  @override
  State<EditarEventoPage> createState() => _EditarEventoPageState();
}

class _EditarEventoPageState extends State<EditarEventoPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  var controllerTitulo = TextEditingController();
  var controllerDescricao = TextEditingController();

  void initState() {
    super.initState();

    controllerTitulo =
        new TextEditingController(text: widget.evento.title as String);
    controllerDescricao =
        new TextEditingController(text: widget.evento.descricao as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          centerTitle: true,
          title: SizedBox(
            height: 48.0,
            child: Image.asset('assets/logo_universidade.png'),
          ),
          leading: ElevatedButton(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30.0,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrangeAccent, // Define a cor de fundo
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => OrganizadorPage()));
            },
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
        body: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),

            // CONTAINER PARA A FOTO DO EVENTO ----------------------------
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: 10,
              height: 200,
              //color: Colors.white,
              //color: Color.fromARGB(255, 227, 30, 37),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://static.vecteezy.com/system/resources/previews/006/692/012/original/calendar-date-date-notes-business-office-event-icon-template-black-color-editable-calendar-date-symbol-flat-illustration-for-graphic-and-web-design-free-vector.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              height: 35,
              alignment: Alignment.centerRight,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {},
                child: Text('Alterar Imagem'),
              ),
            ),

            //*************
            const SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: controllerTitulo,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Título',
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

            const SizedBox(
              height: 10,
            ),

            TextFormField(
              controller: controllerDescricao,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Descrição',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              maxLines: 6, // Permite múltiplas linhas
            ),

            const SizedBox(
              height: 30,
            ),

            Column(
              children: [
                OutlinedButton(
                  child: Text(
                    'Atualizar Evento',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    minimumSize: Size(120.0, 50.0),
                  ),
                  onPressed: () {
                    //
                    var updatedados =
                        FirebaseFirestore.instance.collection('eventos');

                    updatedados
                        .doc(widget.evento.id)
                        .update({
                          'title': controllerTitulo.text,
                          'descricao': controllerDescricao.text
                        })
                        .then((_) => print('Updated'))
                        .catchError((error) => print('Update failed: $error'));

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
                              Text('Dados atualizados com sucesso!'),
                            ],
                          ),
                          height: 60.0,
                        ),
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ));
  }
}
