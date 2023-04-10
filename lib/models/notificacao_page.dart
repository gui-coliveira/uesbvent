// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

class NotificacaoPage extends StatelessWidget {
  const NotificacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textarea = TextEditingController();
    String notificacao = '';

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: SizedBox(
          height: 48.0,
          child: Image.asset('assets/logo_uesb.png'),
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Notificação",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              onChanged: (text) {
                notificacao = text;
              },
              controller: textarea,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              maxLines: 15,
              onFieldSubmitted: (value) {
                if (notificacao.isNotEmpty) {
                  textarea.clear();
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
                            Text('Notificação enviada com sucesso!'),
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
                            Text('Notificação não pode ser vazia!'),
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
            Container(
              height: 40,
              margin: const EdgeInsets.fromLTRB(200, 15, 0, 0),
              alignment: Alignment.bottomRight,
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: const Text(
                    "Enviar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    if (notificacao.isNotEmpty) {
                      textarea.clear();
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
                                Text('Notificação enviada com sucesso!'),
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
                                Text('Notificação não pode ser vazia!'),
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
            ),
          ],
        ),
      ),
    );
  }
}
