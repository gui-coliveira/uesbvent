// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uesbvent/models/login_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uesbvent/models/usuario.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final firebaseAuth = FirebaseAuth.instance;
  final controllerNome = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerCelular = TextEditingController();
  final controllerDtNascimento = TextEditingController();
  final controllerCurso = TextEditingController();

  var maskFormatterCelular = new MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var maskFormatterData = new MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final opcoesSexo = ['Masculino', 'Feminino', 'Outro'];
  String? valueSexo;

  bool esconderSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        color: Colors.indigo,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/logo_uesb.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Dados Cadastrais',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            SizedBox(height: 20),

            TextFormField(
              controller: controllerNome,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Nome Completo *",
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

            SizedBox(height: 10),

            TextFormField(
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "E-mail *",
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
              controller: controllerPassword,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  },
                  child: Icon(
                      esconderSenha ? Icons.visibility : Icons.visibility_off),
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: "Senha *",
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              obscureText: esconderSenha,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 10),

            TextFormField(
              controller: controllerCelular,
              inputFormatters: [maskFormatterCelular],
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Celular",
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

            SizedBox(height: 10),

            TextFormField(
              controller: controllerDtNascimento,
              keyboardType: TextInputType.datetime,
              inputFormatters: [maskFormatterData],
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Data de Nascimento (dd/mm/aaaa) *",
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

            //SEXO--------------------------------------------------------
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5), topLeft: Radius.circular(5)),
              ),
              child: DropdownButton<String>(
                hint: Text(
                  'Sexo',
                  style: TextStyle(color: Colors.grey),
                ),
                value: valueSexo,
                isExpanded: true,
                iconSize: 36,
                items: opcoesSexo.map(buildMenuItem).toList(),
                onChanged: (valueSexo) =>
                    setState(() => this.valueSexo = valueSexo),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controllerCurso,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Curso",
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
              height: 5,
            ),

            //BOTÃO CADASTRAR -------------------------------------------
            Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(110, 20, 110, 40),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  )),
              child: SizedBox.expand(
                child: TextButton(
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    if (controllerNome.text.isNotEmpty &&
                        controllerEmail.text.isNotEmpty &&
                        controllerPassword.text.isNotEmpty &&
                        controllerDtNascimento.text.isNotEmpty) {
                      final usuario = Usuario(
                        nome: controllerNome.text,
                        email: controllerEmail.text,
                        senha: controllerPassword.text,
                        celular: controllerCelular.text,
                        dtNascimento: controllerDtNascimento.text,
                        sexo: valueSexo,
                        curso: controllerCurso.text,
                        org: 'n',
                      );

                      criarUsuario(usuario);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.warning_outlined,
                                color: Colors.white,
                                size: 30.0,
                              ),
                              Text('   '),
                              Text('Preencha todos os campos obrigatórios!'),
                            ],
                          ),
                          height: 60.0,
                        ),
                        behavior: SnackBarBehavior.fixed,
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String opcoesSexo) => DropdownMenuItem(
        value: opcoesSexo,
        child: Text(
          opcoesSexo,
          style: TextStyle(fontSize: 16),
        ),
      );

  Future criarUsuario(Usuario usuario) async {
    try {
      //Cria o usuário na Autenticação
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: controllerEmail.text, password: controllerPassword.text);

      if (userCredential != null) {
        userCredential.user!.updateDisplayName(controllerNome.text);
        userCredential.user!.updateEmail(controllerEmail.text);
        userCredential.user!.updatePassword(controllerPassword.text);

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
                  Text('Cadastro realizado com sucesso!'),
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

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      }
      //Cria o usuário no Banco
      final currentUser = FirebaseAuth.instance.currentUser;
      final docUser = FirebaseFirestore.instance
          .collection('usuarios')
          .doc(currentUser?.uid);
      usuario.id = currentUser!.uid;
      // docUser.set(id as i) = ;

      final json = usuario.toJson();
      await docUser.set(json);
      //--------
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
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
                  Text('Crie uma senha mais forte!'),
                ],
              ),
              height: 60.0,
            ),
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.red,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
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
                  Text('Este Email já está cadastrado!'),
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
  }
}
