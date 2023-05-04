import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uesbvent/models/codSeguranca_page.dart';
import 'package:uesbvent/models/eventosInscritos_page.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:uesbvent/models/recover_page.dart';
import 'package:uesbvent/models/usuario.dart';
import 'package:uesbvent/models/validarcertificado_page.dart';

class CrachaVirtualPage extends StatefulWidget {
  //const CrachaVirtualPage(Usuario usuario, {super.key});
  /*final Usuario usuario;
  CrachaVirtualPage(this.usuario);*/

  @override
  State<CrachaVirtualPage> createState() => _CrachaVirtualPageState();
}

class _CrachaVirtualPageState extends State<CrachaVirtualPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 30, 37),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => EventosInscritosPage()));
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: currentUser?.displayName == null
                      ? Icon(Icons.person)
                      : Text(
                          '${currentUser?.displayName![0]}',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                ),
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
              ListTile(
                leading: Icon(Icons.check),
                title: Text("Eventos Inscritos"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventosInscritosPage()));
                },
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),

            // CONTAINER PARA A FOTO DE PERFIL ----------------------------
            Container(
              padding: const EdgeInsets.fromLTRB(95, 0, 95, 0),
              height: 150,
              color: Color.fromARGB(255, 227, 30, 37),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Icon(Icons.person),
                  )
                ],
              ),
            ),

            //*************
            const SizedBox(
              height: 10,
            ),

            // CONTAINER PARA O NOME DO USUÁRIO ----------------------------
            Container(
              alignment: Alignment.center,
              child: Text(
                currentUser?.displayName as String,
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),

            //*************
            const SizedBox(
              height: 10,
            ),

            // CONTAINER PARA O EMAIL DO USUÁRIO ----------------------------
            Container(
              alignment: Alignment.center,
              child: Text(
                currentUser?.email as String,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),

            //*************
            const SizedBox(
              height: 10,
            ),

            //Container QR Code
            Container(
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              height: 350,
              color: Color.fromARGB(255, 227, 30, 37),
              alignment: Alignment.center,
              child: Image.asset('assets/qrcode.png'),
            ),

            /*// CONTAINER PARA O CURSO DO USUÁRIO ----------------------------
            Container(
              alignment: Alignment.center,
              child: Text(
                currentUser?.,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),*/

            //**********************
          ],
        ));
  }
}
