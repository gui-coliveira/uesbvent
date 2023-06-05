import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uesbvent/models/cadastroCertificado_page.dart';
import 'criarEvento_page.dart';
import 'membros_page.dart';
import 'notificacao_page.dart';
import 'usuario.dart';
import 'package:uesbvent/models/organizador_page.dart';
import 'package:uesbvent/models/codSeguranca_page.dart';
import 'package:uesbvent/models/eventosInscritos_page.dart';
import 'package:uesbvent/models/recover_page.dart';
import 'package:uesbvent/models/validarcertificado_page.dart';

class ParticipantesEventoPage extends StatefulWidget {
  const ParticipantesEventoPage({super.key});

  @override
  State<ParticipantesEventoPage> createState() =>
      _ParticipantesEventoPageState();
}

class _ParticipantesEventoPageState extends State<ParticipantesEventoPage> {
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
            child: Text('Voltar'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => OrganizadorPage()));
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
      body: FutureBuilder<List<Usuario>>(
        future: readUsuarios().first,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final usuarios = snapshot.data!;

            return ListView(
              children: usuarios.map(buildUsuario).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<Usuario>> readUsuarios() => FirebaseFirestore.instance
      .collection('usuarios')
      .where('org', isEqualTo: 'n')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Usuario.fromJson(doc.data())).toList());

  Widget buildUsuario(Usuario usuario) => ListTile(
        leading: CircleAvatar(child: Text('${usuario.nome[0]}')),
        title: Text(usuario.nome),
        subtitle: Text(usuario.email),
        trailing: TextButton(
          child: Text('Emitir certificado'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => CadastroCertificadoPage()));
          },
        ),
      );
}
