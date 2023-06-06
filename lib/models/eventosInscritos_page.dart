import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uesbvent/models/evento_page.dart';

import 'codSeguranca_page.dart';
import 'evento.dart';
import 'login_page.dart';
import 'recover_page.dart';
import 'validarcertificado_page.dart';

class EventosInscritosPage extends StatefulWidget {
  const EventosInscritosPage({super.key});

  @override
  State<EventosInscritosPage> createState() => _EventosInscritosPageState();
}

class _EventosInscritosPageState extends State<EventosInscritosPage> {
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text('Eventos Inscritos',
            style: TextStyle(
              fontSize: 30,
            )),
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
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       UserAccountsDrawerHeader(
      //         currentAccountPicture: CircleAvatar(
      //             child: currentUser?.displayName == null
      //                 ? Icon(Icons.person)
      //                 : Text('${currentUser?.displayName![0]}',
      //                     style: TextStyle(
      //                       fontSize: 30,
      //                     ))),
      //         accountName: currentUser?.displayName != null
      //             ? Text(currentUser?.displayName as String)
      //             : Text(
      //                 'Visitante',
      //                 style: TextStyle(fontSize: 18),
      //               ),
      //         accountEmail: currentUser?.email != null
      //             ? Text(currentUser?.email as String)
      //             : Text(''),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.person),
      //         title: Text("Meu perfil"),
      //         onTap: () {
      //           Navigator.pop(context);
      //           //Navegar para outra página
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.event_rounded),
      //         title: Text("Eventos Inscritos"),
      //         onTap: () {
      //           Navigator.pop(context);
      //           //Navegar para outra página
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.notifications),
      //         title: Text("Notificações"),
      //         onTap: () {
      //           Navigator.pop(context);
      //           //Navegar para outra página
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.bookmark_added_rounded),
      //         title: Text("Validar certificado"),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => ValidarCertificadoPage()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.emergency),
      //         title: Text("Recuperar acesso"),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.of(context).push(
      //               MaterialPageRoute(builder: (context) => RecoverPage()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.security),
      //         title: Text("Código de segurança"),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Navigator.of(context).push(MaterialPageRoute(
      //               builder: (context) => CodSegurancaPage()));
      //         },
      //       ),
      //     ],
      //   ),
      // ),
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
          if (isJaInscrito == true) {
            return ListView(
              children: eventos.map(buildEvento).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
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

  Future<bool> jaInscrito() async {
    await FirebaseFirestore.instance
        .collection('inscricoes')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['usuarioId'] == currentUser!.uid) {
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
}
