import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_karla/src/pages/show_event/stores/show_event_store.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/bottom_button_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/bottom_navigation_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/event_content_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/event_form_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/header_widget.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:asuka/asuka.dart' as asuka;

class ShowEventPage extends StatefulWidget {
  EventModel? eventModel;
  ShowEventPage({this.eventModel});
  @override
  _ShowEventPageState createState() => _ShowEventPageState();
}

class _ShowEventPageState extends State<ShowEventPage> {
  final store = ShowEventStore();

  @override
  void initState() {
    store.initEvent(widget.eventModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Observer(
              builder: (context) => HeaderWidget(
                event: store.event,
                txtTitle: store.txtTitle,
                edit: store.editing,
              ),
            ),
            Observer(
              builder: (context) => store.editing
                  ? EventFormWidget(
                      txtDescription: store.txtDescription,
                      txtDate: store.txtDate,
                      txtConfirmText: store.txtConfirmText,
                      txtCancelText: store.txtCancelText,
                    )
                  : EventContentWidget(
                      eventModel: store.event,
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (context) => store.editing
            ? BottomButtonWidget(onClick: store.toggleEdit)
            : BottomNavigationWidget(
                visualizeOption: showResponses,
                editOption: store.toggleEdit,
                addOption: showAddResponseDialog,
              ),
      ),
    );
  }

  void showResponses() {
    asuka.showBottomSheet(
      (bottomSheetContext) => Container(
        height: MediaQuery.of(bottomSheetContext).size.height - 220,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: store.style.bottomSheetStyle.copyWith(color: Theme.of(context).cardColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Respostas',
                    style: store.textTheme.titleStyle.copyWith(
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
                itemCount: store.event.responses.length,
                itemBuilder: (context, index) => ListTile(
                  tileColor: index % 2 == 0 ? null : Colors.grey.withAlpha(50),
                  title: Text(store.event.responses[index].guestName),
                  trailing: Text(store.event.responses[index].confirm
                      ? store.event.confirmTextFormated
                      : store.event.cancelTextFormated),
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
}
