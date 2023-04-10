import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'codSeguranca_page.dart';
import 'login_page.dart';
import 'recover_page.dart';
import 'validarcertificado_page.dart';

class InscricaoEventoPage extends StatefulWidget {
  const InscricaoEventoPage({super.key});

  @override
  State<InscricaoEventoPage> createState() => _InscricaoEventoPageState();
}

class _InscricaoEventoPageState extends State<InscricaoEventoPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 30, 37),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 50, 133),
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
            // ListTile(
            //   leading: Icon(Icons.bolt_rounded),
            //   title: Text("TESTE"),
            //   onTap: () {
            //     // final User user = auth.currentUser as User;

            //     print(currentUser?.email);
            //   },
            // ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        height: 500,
        width: 400,
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: [
            // Container para guardar a imagem do evento ------------------------
            Container(
              width: 340,
              height: 170,
              color: Colors.blue,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Container para o Título do evento --------------------------------
                Container(
                  height: 30,
                  width: 280,
                  //color: Color.fromARGB(255, 111, 226, 255),
                  margin: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                  child: const Text(
                    "Título",
                    textAlign: TextAlign.justify,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),

                // Container para favoritar evento ---------------------------------
                Container(
                  height: 30,
                  width: 50,
                  //color: Colors.blue,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: IconButton(
                    icon: const Icon(Icons.star_border_outlined),
                    iconSize: 35,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // Container para a descrição do evento
            Container(
              height: 200,
              width: 330,
              //color: Colors.grey,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Descrição............',
                  maxLines: 80,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            // Botão de inscrever-se -------------------------------------------
            Container(
              height: 40,
              width: 150,
              margin: const EdgeInsets.fromLTRB(170, 3, 0, 0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 57, 50, 133),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  )),
              child: SizedBox.expand(
                child: TextButton(
                  child: const Text(
                    "Inscrever-se",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
