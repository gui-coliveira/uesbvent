// ignore: implementation_imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'usuario.dart';

// ignore: implementation_imports
class EditMembros extends StatefulWidget {
  final String texto;

  const EditMembros(this.texto, {super.key});

  @override
  State<EditMembros> createState() => _EditMembrosState();
}

class _EditMembrosState extends State<EditMembros> {
  @override
  Widget build(BuildContext context) {
    if (widget.texto == "Membros") {
      return Scaffold(
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
    } else {
      return Scaffold(
        body: FutureBuilder<List<Usuario>>(
          future: readOrganizadores().first,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final usuarios = snapshot.data!;

              return ListView(
                children: usuarios.map(buildOrganizador).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
    }
  }

  Stream<List<Usuario>> readUsuarios() => FirebaseFirestore.instance
      .collection('usuarios')
      .where('org', isEqualTo: 'n')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Usuario.fromJson(doc.data())).toList());

  Stream<List<Usuario>> readOrganizadores() => FirebaseFirestore.instance
      .collection('usuarios')
      .where('org', isEqualTo: 's')
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
              // PopupMenuItem(
              //   value: 'editar',
              //   child: Text('Editar'),
              // ),
              PopupMenuItem(
                value: 'promover',
                child: Text('Promover a Organizador'),
              ),
              PopupMenuItem(
                value: 'deletar',
                child: Text('Deletar'),
              ),
            ];
          },
          onSelected: (String value) =>
              actionPopUpItemSelected(value, usuario.id),
        ),
      );

  Widget buildOrganizador(Usuario usuario) => ListTile(
        leading: CircleAvatar(child: Text('${usuario.nome[0]}')),
        title: Text(usuario.nome),
        subtitle: Text(usuario.email),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [
              // PopupMenuItem(
              //   value: 'editar',
              //   child: Text('Editar'),
              // ),
              PopupMenuItem(
                value: 'remover',
                child: Text('Remover de Organizador'),
              ),
              PopupMenuItem(
                value: 'deletar',
                child: Text('Deletar'),
              ),
            ];
          },
          onSelected: (String value) =>
              actionPopUpItemSelected(value, usuario.id),
        ),
      );

  void actionPopUpItemSelected(String value, String id) {
    if (value == 'editar') {
      print('Você selecionou EDITAR');
      setState(() {});
    } else if (value == 'deletar') {
      print('Você selecionou DELETAR');
      final currentUser = FirebaseAuth.instance.currentUser;
      CollectionReference usuarios =
          FirebaseFirestore.instance.collection('usuarios');

      Future<void> deleteUser() {
        return usuarios
            .doc(id)
            .delete()
            .then((value) => print("User Deleted"))
            .catchError((error) => print("Failed to delete user: $error"));
      }

      deleteUser();
      setState(() {});
    } else if (value == 'promover') {
      CollectionReference usuarios =
          FirebaseFirestore.instance.collection('usuarios');

      Future<void> updateUser() {
        return usuarios
            .doc(id)
            .update({'org': 's'})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      }

      updateUser();
      setState(() {});
    } else if (value == 'remover') {
      final currentUser = FirebaseAuth.instance.currentUser;

      CollectionReference usuarios =
          FirebaseFirestore.instance.collection('usuarios');

      Future<void> updateUser() {
        return usuarios
            .doc(id)
            .update({'org': 'n'})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));
      }

      updateUser();
      setState(() {});
      print('Você selecionou REMOVER DE ORG');
    } else {
      print('Not implemented');
    }
  }
}
