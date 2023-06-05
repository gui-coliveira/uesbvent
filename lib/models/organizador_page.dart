// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last

//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uesbvent/models/criarEvento_page.dart';
import 'package:uesbvent/models/editarEvento_page.dart';
import 'package:uesbvent/models/evento_page.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:uesbvent/models/membros_page.dart';
import 'package:uesbvent/models/notificacao_page.dart';
import 'package:uesbvent/models/presenca_page.dart';
import '../models/evento.dart';
import 'participantesEvento_page.dart';

// ignore: must_be_immutable
class OrganizadorPage extends StatefulWidget {
  const OrganizadorPage({Key? key}) : super(key: key);

  @override
  State<OrganizadorPage> createState() => _OrganizadorPageState();
}

class _OrganizadorPageState extends State<OrganizadorPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: currentUser?.displayName == null
                      ? Icon(Icons.person)
                      : Text('${currentUser?.displayName![0]}',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ))),
              accountName: currentUser?.displayName != null
                  ? Text(currentUser?.displayName as String)
                  : Text(
                      'Visitante',
                      style: TextStyle(fontSize: 18),
                    ),
              accountEmail: currentUser?.email != null
                  ? Text(currentUser?.email as String)
                  : Text(''),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Meu perfil"),
              onTap: () {
                Navigator.pop(context);
                //Navegar para outra página
              },
            ),
            ListTile(
              leading: Icon(Icons.event_rounded),
              title: Text("Eventos Inscritos"),
              onTap: () {
                Navigator.pop(context);
                //Navegar para outra página
              },
            ),
            ListTile(
              leading: Icon(Icons.create_new_folder_rounded),
              title: Text("Criar Evento"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CriarEvento_Page()));
                //Navegar para outra página
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_on_rounded),
              title: Text("Enviar Notificação"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NotificacaoPage()));
                //Navegar para outra página
              },
            ),
            ListTile(
              leading: Icon(Icons.person_search_rounded),
              title: Text("Lista de Membros"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MembrosPage()));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          buildEventList(), //Lista de Eventos
        ],
      ),
    );
  }

  Future<void> signOut() async {
    print('Sign Out');
    await FirebaseAuth.instance.signOut();
  }

  Widget buildEventList() {
    return FutureBuilder<List<Evento>>(
      future: readEventos().first,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final eventos = snapshot.data!;
          return ListView(
            children: eventos.map(buildEvento).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Stream<List<Evento>> readEventos() => FirebaseFirestore.instance
      .collection('eventos')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Evento.fromJson(doc.data())).toList());

  Widget buildEvento(Evento evento) => ListTile(
        //leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(
          evento.title,
          maxLines: 1,
        ),
        subtitle: Text(
          evento.descricao,
          maxLines: 2,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          print('Selecionou ' + evento.title);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EventoPage(evento)));
        },
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'visualizar',
                child: Text('Visualizar'),
              ),
              PopupMenuItem(
                value: 'presenca',
                child: Text('Validar Presença'),
              ),
              PopupMenuItem(
                value: 'cadastrarcertificados',
                child: Text('Cadastrar Certificados'),
              ),
              PopupMenuItem(
                value: 'editar',
                child: Text('Editar'),
              ),
              PopupMenuItem(
                value: 'deletar',
                child: Text('Deletar'),
              ),
            ];
          },
          onSelected: (String value) {
            actionPopUpItemSelected(value, evento);
          },
        ),
      );

  void actionPopUpItemSelected(String value, Evento evento) {
    if (value == 'visualizar') {
      print('VISUALIZAR EVENTO');
      print(evento.title);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => EventoPage(evento)));
      //---------------------
      //---------------------
    } else if (value == 'presenca') {
      print('PRESENCA');
      print(evento.title);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PresencaPage(evento)));
      //---------------------
      //---------------------
    } else if (value == 'cadastrarcertificados') {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ParticipantesEventoPage()));
      //---------------------
      //---------------------
    } else if (value == 'editar') {
      print('EDITAR');
      print(evento.title);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditarEventoPage(evento)));
      //---------------------
      //---------------------
    } else if (value == 'deletar') {
      deleteEvent(evento.id);
      setState(() {});
      //---------------------
      //---------------------
    } else {
      print('Not implemented');
      //---------------------
      //---------------------
    }
  }

  Future<void> deleteEvent(String id) {
    final eventos = FirebaseFirestore.instance.collection('eventos');

    return eventos
        .doc(id)
        .delete()
        .then((_) => print('Deletado'))
        .catchError((error) => print('Delete failed: $error'));
  }
}
