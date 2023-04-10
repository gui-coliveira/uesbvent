import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uesbvent/models/usuario.dart';

// ignore: must_be_immutable
class PresencaPage extends StatefulWidget {
  PresencaPage({super.key}) {}

  @override
  State<PresencaPage> createState() => _PresencaPageState();
}

class _PresencaPageState extends State<PresencaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 254),
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: SizedBox(
          height: 48.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Validar Presença  '),
              Icon(Icons.domain_verification),
              //Image.asset('assets/logo_uesb.png'),
            ],
          ),
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
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Usuario.fromJson(doc.data())).toList());

  Widget buildUsuario(Usuario usuario) => ListTile(
        leading: CircleAvatar(child: Text('${usuario.nome[0]}')),
        title: Text(usuario.nome),
        subtitle: Text(usuario.email),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'presencaok',
                child: Text('Validar Presença'),
              ),
            ];
          },
          onSelected: (String value) =>
              actionPopUpItemSelected(value, usuario.id),
        ),
      );
}

void actionPopUpItemSelected(String value, String id) {
  if (value == 'presencaok') {
    print('Você selecioneou VALIDAR PRESENÇA');
  } else {
    print('Not implemented');
  }
}
