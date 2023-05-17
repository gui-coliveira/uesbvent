// ignore_for_file: sort_child_properties_last, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uesbvent/models/evento.dart';
import 'package:uesbvent/models/home_page.dart';
import 'package:uesbvent/models/inscricao.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:uesbvent/models/usuario.dart';

import 'organizador_page.dart';

class EventoPage extends StatefulWidget {
  final Evento evento;
  EventoPage(this.evento);

  @override
  State<EventoPage> createState() => _EventoPageState();
}

class _EventoPageState extends State<EventoPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final currentUser = FirebaseAuth.instance.currentUser;
  int usuarioInscrito = 0;
  bool isJaInscrito = false;

  @override
  void initState() {
    super.initState();
    jaInscrito().then((value) {
      setState(() {
        isJaInscrito = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
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
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              )),
          child: Column(
            children: [
              Text(
                widget.evento.title,
                maxLines: 2,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                  height: 286,
                  width: 350,
                  margin: const EdgeInsets.fromLTRB(0, 175, 0, 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      widget.evento.descricao,
                      maxLines: 20,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                child: Text(
                  isJaInscrito == false && currentUser?.displayName != null
                      ? 'Inscrever-se'
                      : currentUser?.displayName != null
                          ? 'Inscrito'
                          : 'Realizar Login',
                  style: TextStyle(fontSize: 14),
                ),
                style: isJaInscrito == false && currentUser?.displayName != null
                    ? OutlinedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        minimumSize: Size(120.0, 50.0),
                      )
                    : OutlinedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        minimumSize: Size(120.0, 50.0),
                      ),
                onPressed: () {
                  if (isJaInscrito == false &&
                      currentUser?.displayName != null) {
                    inscreverEvento(currentUser!.uid, widget.evento.id);
                    setState(() {});
                  } else if (currentUser?.displayName == null) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  } else {
                    null;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future inscreverEvento(String? usuarioId, String eventoId) async {
    try {
      final inscricao =
          Inscricao(usuarioId: usuarioId!, eventoId: eventoId, presente: 'n');

      final docUser = FirebaseFirestore.instance.collection('inscricoes').doc();

      inscricao.id = docUser.id;

      final json = inscricao.toJson();
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
                Text('Inscrição realizada com Sucesso!'),
              ],
            ),
            height: 60.0,
          ),
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.green,
        ),
      );

      FirebaseFirestore.instance
          .collection('usuarios')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc['org'] == 's' && doc['id'] == currentUser?.uid) {
            print(doc['org']);
            print(doc['id']);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => OrganizadorPage()));

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => OrganizadorPage()),
                (route) => false);
          }
        });
      });

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
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

  Future<bool> jaInscrito() async {
    await FirebaseFirestore.instance
        .collection('inscricoes')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['eventoId'] == widget.evento.id &&
            doc['usuarioId'] == currentUser!.uid) {
          usuarioInscrito = 1;
        }
      });
    });

    if (usuarioInscrito == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> signOut() async {
    print('Sign Out');
    await FirebaseAuth.instance.signOut();
  }
}
