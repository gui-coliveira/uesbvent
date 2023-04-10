// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uesbvent/models/cadastro_page.dart';
import 'package:uesbvent/models/home_page.dart';

import 'package:uesbvent/models/recover_page.dart';
import 'package:uesbvent/models/usuario.dart';

import 'organizador_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final firebaseAuth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool esconderSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 150,
                  child: Image.asset("assets/logo_universidade.png"),
                ),

                SizedBox(height: 30),
                //TITULO-------------------------------------------------------
                Text(
                  'UESBVENT',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.white),
                ),

                Text(
                  'Portal de Eventos',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(height: 20),

                //CAMPO EMAIL ----------------------------------
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.person_outline),
                    disabledBorder: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (value) {
                    login();
                  },
                ),
                SizedBox(height: 15),

                //CAMPO PASSWORD ------------------------------------------------
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          esconderSenha = !esconderSenha;
                        });
                      },
                      child: Icon(esconderSenha
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    disabledBorder: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (value) {
                    login();
                  },
                  obscureText: esconderSenha,
                ),

                //BOTÃO ESQUECEU SENHA -----------------------------------------
                Container(
                  height: 35,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white70),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RecoverPage()));
                    },
                    child: Text('esqueceu a senha?'),
                  ),
                ),

                SizedBox(height: 20),

                //BOTÃO ENTRAR ---------------------------------------------------
                OutlinedButton(
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(120.0, 50.0),
                  ),
                  onPressed: () {
                    login();
                  },
                ),

                SizedBox(height: 30),

                // BOTÃO CONTINUAR COMO VISITANTE ------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        foregroundColor: Colors.white,
                        minimumSize: Size(170.0, 50.0),
                        maximumSize: Size(170.0, 50.0),
                      ),
                      onPressed: () {
                        signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      },
                      child: Text(
                        'continuar como visitante',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),

                    //BOTÃO INSCREVA-SE ------------
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        foregroundColor: Colors.white,
                        minimumSize: Size(170.0, 50.0),
                        maximumSize: Size(170.0, 50.0),
                      ),
                      onPressed: () {
                        //LOGIN CORRETO
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CadastroPage()));
                      },
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential != null) {
        final currentUser = FirebaseAuth.instance.currentUser;

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
            }
          });
        });

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
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
                  Text('Email inválido!'),
                ],
              ),
              height: 60.0,
            ),
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'wrong-password') {
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
                  Text('Senha inválida!'),
                ],
              ),
              height: 60.0,
            ),
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.red,
          ),
        );
      } else {
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
                  Text('Usuário e/ou senha inválidos!'),
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
  }
}

Future<void> signOut() async {
  print('Sign Out');
  await FirebaseAuth.instance.signOut();
}
