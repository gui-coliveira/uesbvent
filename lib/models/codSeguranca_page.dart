// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:uesbvent/models/redefinir_page.dart';

class CodSegurancaPage extends StatefulWidget {
  const CodSegurancaPage({super.key});

  @override
  State<CodSegurancaPage> createState() => _CodSegurancaPageState();
}

class _CodSegurancaPageState extends State<CodSegurancaPage> {
  String codigo = '';

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
                  'Código de Segurança',
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
                  'Insira o código de segurança\nrecebido por email ou celular',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),

                SizedBox(height: 15),

                //CAMPO CÓDIGO SEGURANÇA ----------------------------------
                SizedBox(
                  width: 220,
                  child: TextFormField(
                    onChanged: (text) {
                      codigo = text;
                    },
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    maxLength: 5,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.security_outlined,
                        size: 30,
                      ),
                      disabledBorder: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (value) {
                      if (codigo == '12345') {
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
                                  Text('Código validado!'),
                                ],
                              ),
                              height: 60.0,
                            ),
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => RedefinirPage()));
                      } else {
                        //CÓDIGO INCORRETO
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
                                  Text('Código inválido!'),
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
                ),

                SizedBox(height: 15),

                //BOTÃO VALIDAR ---------------------------------------------------
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(120.0, 50.0),
                    maximumSize: Size(120.0, 50.0),
                  ),
                  onPressed: () {
                    //CÓDIGO CORRETO
                    if (codigo == '12345') {
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
                                Text('Código validado!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => RedefinirPage()));
                    } else {
                      //CÓDIGO INCORRETO
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
                                Text('Código inválido!'),
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
