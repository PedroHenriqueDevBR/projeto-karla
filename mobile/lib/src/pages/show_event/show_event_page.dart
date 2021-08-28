import 'package:flutter/material.dart';
import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/bottom_button_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/bottom_navigation_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/header_widget.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:projeto_karla/src/shared/models/response_model.dart';

class ShowEventPage extends StatefulWidget {
  EventModel? eventModel;
  ShowEventPage({this.eventModel});
  @override
  _ShowEventPageState createState() => _ShowEventPageState();
}

class _ShowEventPageState extends State<ShowEventPage> {
  late EventModel event;
  final _textTheme = AppTextTheme();
  final _txtTitle = TextEditingController();
  final _style = ShowEventStyle();
  bool editing = false;

  void initEvent(EventModel? eventArg) {
    this.event = eventArg ?? EventModel.empty();
    event.responses.addAll([
      ResponseModel(guestName: 'Pedro', confirm: true, responseDate: DateTime.now()),
      ResponseModel(guestName: 'Pedro', confirm: false, responseDate: DateTime.now()),
      ResponseModel(guestName: 'Pedro', confirm: true, responseDate: DateTime.now()),
      ResponseModel(guestName: 'Pedro', confirm: true, responseDate: DateTime.now()),
      ResponseModel(guestName: 'Pedro', confirm: false, responseDate: DateTime.now()),
    ]);
  }

  void toggleEdit() {
    setState(() {
      editing = !editing;
    });
  }

  void showResponses() {
    asuka.showBottomSheet(
      (bottomSheetContext) => Container(
        height: MediaQuery.of(bottomSheetContext).size.height - 220,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: _style.bottomSheetStyle.copyWith(color: Theme.of(context).cardColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Respostas',
                    style: _textTheme.titleStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(bottomSheetContext);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: event.responses.length,
                itemBuilder: (context, index) => ListTile(
                  tileColor: index % 2 == 0 ? null : Colors.grey.withAlpha(50),
                  title: Text(event.responses[index].guestName),
                  trailing: Text(event.responses[index].confirm ? event.confirmTextFormated : event.cancelTextFormated),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddResponseDialog() {
    asuka.showDialog(
      builder: (dialogContext) => AlertDialog(
        title: Text('Nova resposta'),
        content: Container(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome do convidado',
                  hintText: 'Digite o nome do convidado',
                ),
              ),
              SizedBox(height: 80.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Salvar'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(
                        'Cancelar resposta',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
              edit: editing,
            ),
            editing ? _eventform() : _eventContent(),
          ],
        ),
      ),
      bottomNavigationBar: editing
          ? BottomButtonWidget(onClick: toggleEdit)
          : BottomNavigationWidget(
              visualizeOption: showResponses,
              editOption: toggleEdit,
              addOption: showAddResponseDialog,
            ),
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
            'Data limite: ${event.formatedDate}',
            style: _textTheme.subtitleStyle.copyWith(fontSize: 14),
          ),
          SizedBox(height: 4.0),
          Text(
            'Respostas: ${event.responses.length}',
            style: _textTheme.subtitleStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _eventform() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              minLines: 5,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Descrição',
                hintText: 'Descreva o evento',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Data',
                hintText: 'Data limite para resposta',
                suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.date_range)),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Texto confirmar',
                hintText: 'Texto para confirmar presença',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Texto cancelar',
                hintText: 'Texto para cancelar presença',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
