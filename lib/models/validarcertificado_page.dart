// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';

class ValidarCertificadoPage extends StatefulWidget {
  const ValidarCertificadoPage({super.key});

  @override
  State<ValidarCertificadoPage> createState() => _ValidarCertificadoPageState();
}

class _ValidarCertificadoPageState extends State<ValidarCertificadoPage> {
  String codigoCertificado = '';

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
                  'Validação de Certificado',
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
                  'Insira o código de validação',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),

                SizedBox(height: 15),

                //CAMPO EMAIL ----------------------------------
                TextFormField(
                  onChanged: (text) {
                    codigoCertificado = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    disabledBorder: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (value) {
                    if (codigoCertificado == 'teste') {
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
                                Text('Certificado válido!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.green,
                        ),
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
                                Text('Certificado não encontrado ou inválido!'),
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
                    if (codigoCertificado == 'teste') {
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
                                Text('Certificado válido!'),
                              ],
                            ),
                            height: 60.0,
                          ),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.green,
                        ),
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
                                Text('Certificado não encontrado ou inválido!'),
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
                        'Verificar',
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
