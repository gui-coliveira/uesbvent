// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uesbvent/models/codSeguranca_page.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:uesbvent/models/recover_page.dart';
import 'package:uesbvent/models/validarcertificado_page.dart';
import '../models/evento.dart';
import 'evento_page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // UserCredential userCredential = FirebaseAuth.instance.;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  // Stream<List<Usuario>> readUsuarios() => FirebaseFirestore.instance
  //     .collection('usuarios')
  //     .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => Usuario.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
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

        // const [Icon(Icons.filter_alt_rounded)]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  child: currentUser?.displayName == null
                      ? Icon(Icons.person)
                      : Text('${currentUser?.displayName![0]}',
                          style: TextStyle(
                            fontSize: 30,
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
              leading: Icon(Icons.notifications),
              title: Text("Notificações"),
              onTap: () {
                Navigator.pop(context);
                //Navegar para outra página
              },
            ),
            ListTile(
              leading: Icon(Icons.bookmark_added_rounded),
              title: Text("Validar certificado"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ValidarCertificadoPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.emergency),
              title: Text("Recuperar acesso"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RecoverPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text("Código de segurança"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CodSegurancaPage()));
              },
            ),
          ],
        ),
      ),
      body: buildEventList(),
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
    } else {
      print('Not implemented');
      //---------------------
      //---------------------
    }
  }
}
