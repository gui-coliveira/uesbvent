import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uesbvent/models/codSeguranca_page.dart';
import 'package:uesbvent/models/eventosInscritos_page.dart';
import 'package:uesbvent/models/participantesEvento_page.dart';
import 'package:uesbvent/models/recover_page.dart';
import 'package:uesbvent/models/validarcertificado_page.dart';

import 'criarEvento_page.dart';
import 'membros_page.dart';
import 'notificacao_page.dart';

class CadastroCertificadoPage extends StatefulWidget {
  const CadastroCertificadoPage({super.key});

  @override
  State<CadastroCertificadoPage> createState() =>
      _CadastroCertificadoPageState();
}

class _CadastroCertificadoPageState extends State<CadastroCertificadoPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  List<PlatformFile> arquivos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
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
                  builder: (context) => ParticipantesEventoPage()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: currentUser?.displayName == null
                      ? Icon(Icons.person)
                      : Text('${currentUser?.displayName![0]}',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
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
              leading: Icon(Icons.event_rounded),
              title: Text("Eventos Inscritos"),
              onTap: () {
                Navigator.pop(context);
                //Navegar para outra página
              },
            ),
            ListTile(
              leading: Icon(Icons.create_new_folder_rounded),
              title: Text("Criar Evento"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CriarEvento_Page()));
                //Navegar para outra página
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications_on_rounded),
              title: Text("Enviar Notificação"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NotificacaoPage()));
                //Navegar para outra página
              },
            ),
            ListTile(
              leading: Icon(Icons.person_search_rounded),
              title: Text("Lista de Membros"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MembrosPage()));
              },
            ),
          ],
        ),
      ),

      // Column
      body: RefreshIndicator(
        onRefresh: refresh,
        child: listaPdf(arquivos),
      ),

      // botão de upload ------------------------------------------------
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final resultado = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );
          if (resultado == null) return;

          arquivos = resultado.files;

          //await saveFilePermanently(file);
        },
        label: const Text('Upload'),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  // recarregar a lista -----------------------
  Future<void> refresh() async {
    setState(() {
      listaPdf(arquivos);
    });
  }

  // abrir o arquivo pdf ----------------------
  void openFile(PlatformFile arquivo) {
    OpenFile.open(arquivo.path);
  }

  Widget listaPdf(List<PlatformFile> files) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        return construirArquivo(file);
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  Widget construirArquivo(PlatformFile file) {
    final extension = file.extension ?? 'none';

    return InkWell(
      onTap: () async {
        final newFile = await saveFilePermanently(file);
        openFile(file);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        color: Color.fromARGB(255, 227, 30, 37),
        child: ListTile(
          leading: Text(
            '.$extension',
          ),
          title: Text(file.name),
        ),
      ),
    );
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }
}
