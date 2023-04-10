// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({super.key});

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 60),

                //IMAGEM ------------------------------------
                SizedBox(
                  width: 300,
                  height: 150,
                  child: Image.asset("assets/logo_uesb.png"),
                ),

                SizedBox(height: 15),

                //TITULO-------------------------------------------------------
                Text(
                  'Recuperar Acesso',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),

                SizedBox(height: 5),

                //SUBTITULO -----------------------
                Text(
                  'Insira seu Email',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),

                SizedBox(height: 10),

                //CAMPO EMAIL ----------------------------------
                TextFormField(
                  onChanged: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    disabledBorder: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (value) {
                    if (email == 'teste@gmail.com') {
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
                                Text(
                                    'Instruções de recuperação enviadas ao Email!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      //LOGIN INCORRETO
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
                                Text('Email não encontrado!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),

                SizedBox(height: 15),

                //BOTÃO BUSCAR ---------------------------------------------------
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(120.0, 50.0),
                    maximumSize: Size(120.0, 50.0),
                  ),
                  onPressed: () {
                    //LOGIN CORRETO
                    if (email == 'teste') {
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
                                Text(
                                    'Instruções de recuperação enviadas ao Email!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      //LOGIN INCORRETO
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
                                Text('Email não encontrado!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Confirmar',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
