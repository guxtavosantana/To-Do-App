import 'package:flutter/material.dart';
import 'package:lista_tarefas/tarefa.dart';

void main() {
  runApp(new ListaTarefaApp());
}

class ListaTarefaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new ListaScreen());
  }
}

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  final List<Tarefa> tarefas = new List<Tarefa>();

  TextEditingController inputController = new TextEditingController();

  void adicionaTarefa(String nome) {
    setState(() {
      tarefas.add(Tarefa(nome));
    });

    inputController.clear();
  }

  Widget getItem(Tarefa tarefa) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
            icon: new Icon(
              tarefa.concluida
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: Colors.green,
            ),
            iconSize: 42,
            onPressed: () {
              setState(() {
                tarefa.concluida
                    ? tarefa.concluida = false
                    : tarefa.concluida = true;
              });
            }),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tarefa.nome),
            Text(tarefa.data.toIso8601String())
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Lista de tarefas'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: TextField(
              onSubmitted: (value) {
                adicionaTarefa(value);
              },
              controller: inputController,
              decoration: InputDecoration(hintText: "Tarefa"),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: tarefas.length,
            itemBuilder: (_, indice) {
              return getItem(tarefas[indice]);
            },
          ))
        ],
      ),
    );
  }
}
