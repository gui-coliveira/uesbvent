import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uesbvent/models/codSeguranca_page.dart';
import 'package:uesbvent/models/eventosInscritos_page.dart';
import 'package:uesbvent/models/home_page.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:uesbvent/models/recover_page.dart';
import 'package:uesbvent/models/usuario.dart';
import 'package:uesbvent/models/validarcertificado_page.dart';

class MeuPerfilPage extends StatefulWidget {
  @override
  State<MeuPerfilPage> createState() => _MeuPerfilPageState();
}

class _MeuPerfilPageState extends State<MeuPerfilPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  var controllerNome = TextEditingController();
  var controllerEmail = TextEditingController();
  var controllerPassword = TextEditingController();
  var controllerCelular = TextEditingController();
  var controllerDtNascimento = TextEditingController();
  var controllerCurso = TextEditingController();

  void initState() {
    super.initState();

    controllerNome =
        new TextEditingController(text: currentUser?.displayName as String);
    controllerEmail =
        new TextEditingController(text: currentUser?.email as String);
    // controllerCelular =
    //     new TextEditingController(text: currentUser?.phoneNumber as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
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
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
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

            // CONTAINER PARA A FOTO DE PERFIL ----------------------------
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              width: 10,
              height: 300,
              //color: Color.fromARGB(255, 227, 30, 37),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://louisville.edu/enrollmentmanagement/images/person-icon/image"),
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
              controller: controllerNome,
              //keyboardType: TextInputType,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Nome',
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
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "E-mail",
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
              height: 30,
            ),

            // TextFormField(
            //   controller: controllerCelular,
            //   keyboardType: TextInputType.phone,
            //   decoration: const InputDecoration(
            //       filled: true,
            //       fillColor: Colors.white,
            //       labelText: 'Celular',
            //       labelStyle: TextStyle(
            //         color: Colors.grey,
            //         fontWeight: FontWeight.w400,
            //         fontSize: 15,
            //       )),
            //   style: const TextStyle(
            //     fontSize: 20,
            //     color: Colors.black,
            //   ),
            // ),

            Column(
              children: [
                OutlinedButton(
                  child: Text(
                    'Atualizar Dados',
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
                        FirebaseFirestore.instance.collection('usuarios');

                    updatedados
                        .doc(currentUser?.uid)
                        .update({'nome': controllerNome.text})
                        .then((_) => print('Updated'))
                        .catchError((error) => print('Update failed: $error'));

                    currentUser?.updateDisplayName(controllerNome.text);

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
