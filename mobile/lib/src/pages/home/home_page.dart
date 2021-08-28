import 'package:flutter/material.dart';
import 'package:projeto_karla/src/pages/home/widgets/event_card_widget.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final events = [
    EventModel(
      title: 'Evento 01',
      description: 'Uma descrição qualquer do evento só para teste mesmo',
      background:
          'https://images.pexels.com/photos/1000445/pexels-photo-1000445.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
      expirationDate: DateTime.now(),
    ),
    EventModel(
      title: 'Evento 02',
      description: 'Uma descrição qualquer do evento só para teste mesmo',
      expirationDate: DateTime.now(),
    ),
    EventModel(
      title: 'Evento 03',
      description: 'Uma descrição qualquer do evento só para teste mesmo',
      expirationDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karla App'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Sair',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: EventCardWidget(event: events[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () {},
        label: Text('Evento'),
      ),
    );
  }
}
