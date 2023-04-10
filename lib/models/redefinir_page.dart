// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:uesbvent/models/login_page.dart';

class RedefinirPage extends StatefulWidget {
  const RedefinirPage({super.key});

  @override
  State<RedefinirPage> createState() => _RedefinirPageState();
}

class _RedefinirPageState extends State<RedefinirPage> {
  String novaSenha = '';
  String confNovaSenha = '';
  bool esconderSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
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
                SizedBox(height: 15),

                //IMAGEM ------------------------------------
                SizedBox(
                  width: 300,
                  height: 150,
                  child: Image.asset("assets/logo_uesb.png"),
                ),

                SizedBox(height: 15),

                //TITULO-------------------------------------------------------
                Text(
                  'Redefinição de Senha',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),

                SizedBox(height: 25),

                //TEXTO NOVA SENHA -----------------------
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nova senha *',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),

                //CAMPO NOVA SENHA ----------------------------------
                TextFormField(
                  onChanged: (text) {
                    novaSenha = text;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                  obscureText: esconderSenha,
                  onFieldSubmitted: (value) {
                    //SENHA CORRETA
                    if (novaSenha.isNotEmpty && novaSenha == confNovaSenha) {
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
                                Text('Senha redefinida com sucesso!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } else {
                      //SENHA INCORRETA
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
                                Text('Campos inválidos ou diferentes!'),
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

                SizedBox(height: 5),

                //TEXTO CONFIRMAR NOVA SENHA -----------------------
                Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirme a nova senha *',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),

                //CAMPO CONFIRMAR NOVA SENHA ----------------------------------
                TextFormField(
                  onChanged: (text) {
                    confNovaSenha = text;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    disabledBorder: OutlineInputBorder(),
                  ),
                  obscureText: esconderSenha,
                  onFieldSubmitted: (value) {
                    if (confNovaSenha.isNotEmpty &&
                        novaSenha == confNovaSenha) {
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
                                Text('Senha redefinida com sucesso!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
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
                                Text('Campos inválidos ou diferentes!'),
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

                SizedBox(height: 20),

                //BOTÃO ALTERAR ---------------------------------------------------
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(120.0, 50.0),
                    maximumSize: Size(120.0, 50.0),
                  ),
                  onPressed: () {
                    //LOGIN CORRETO
                    if (novaSenha.isNotEmpty && novaSenha == confNovaSenha) {
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
                                Text('Senha redefinida com sucesso!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
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
                                Text('Campos inválidos ou diferentes!'),
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
                        'Alterar',
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
