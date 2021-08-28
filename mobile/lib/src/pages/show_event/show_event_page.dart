import 'package:flutter/material.dart';
import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/header_widget.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/core/assets.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';

class ShowEventPage extends StatefulWidget {
  EventModel? eventModel;
  ShowEventPage({this.eventModel});
  @override
  _ShowEventPageState createState() => _ShowEventPageState();
}

class _ShowEventPageState extends State<ShowEventPage> {
  late EventModel event;
  final _style = ShowEventStyle();
  final _assets = AppAssets();
  final _textTheme = AppTextTheme();
  final _txtTitle = TextEditingController();

  void initEvent(EventModel? event) {
    this.event = event ?? EventModel.empty();
  }

  @override
  void initState() {
    initEvent(widget.eventModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(
              event: event,
              txtTitle: _txtTitle,
              edit: false,
            ),
            _eventContent(),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _eventContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '''It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.''',
            style: _textTheme.descriptionStyle.copyWith(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Data limite: 00/00/0000',
            style: _textTheme.subtitleStyle.copyWith(fontSize: 14),
          ),
          SizedBox(height: 4.0),
          Text(
            'Respostas: 50',
            style: _textTheme.subtitleStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Salvar alterações'),
      style: _style.bottomButtonStyle,
    );
  }

  Widget _bottomNavigation() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.group_outlined),
          label: 'Visualizar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_outlined),
          label: 'Editar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Resposta',
        ),
      ],
    );
  }
}
