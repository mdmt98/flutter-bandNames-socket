import 'dart:io';

import 'package:band_names/model/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Band> band = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Mago de Oz', votes: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      body: ListView.builder(
        itemCount: band.length,
        itemBuilder: (context, i) => _bandTile(band[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        elevation: 1.0,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) => Dismissible(
        key: Key(band.id!),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          // TODO: delete band
          print('id: ${band.id}');
        },
        background: Container(
          padding: const EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delete Band',
                style: TextStyle(color: Colors.white),
              )),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(band.name!.substring(0, 2)),
          ),
          title: Text(band.name!),
          trailing:
              Text('${band.votes}', style: const TextStyle(fontSize: 20.0)),
          onTap: () {
            print(band.name);
          },
        ),
      );

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text('New band Name:'),
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  MaterialButton(
                    onPressed: () => addBandToList(textController.text),
                    elevation: 5.0,
                    textColor: Colors.blue,
                    child: const Text('add'),
                  ),
                ],
              ));
    }

    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text('New band name'),
              content: CupertinoTextField(controller: textController),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('Add'),
                  onPressed: () => addBandToList(textController.text),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Dismiss'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      band.add(Band(id: DateTime.now().toString(), name: name, votes: 0));

      setState(() {});
    }

    Navigator.pop(context);
  }
}
