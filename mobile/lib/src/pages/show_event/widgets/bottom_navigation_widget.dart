import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';

class BottomNavigationWidget extends StatelessWidget {
  final textTheme = AppTextTheme();
  final style = ShowEventStyle();
  EventModel eventModel;
  VoidCallback editOption;

  BottomNavigationWidget({
    Key? key,
    required this.eventModel,
    required this.editOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _selectOption(int option) {
      if (option == 0) {
        this.showResponses(context);
      } else if (option == 1) {
        editOption();
      } else if (option == 2) {
        showAddResponseDialog();
      }
    }

    return BottomNavigationBar(
      onTap: _selectOption,
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

  void showResponses(BuildContext context) {
    asuka.showBottomSheet(
      (bottomSheetContext) => Container(
        height: MediaQuery.of(bottomSheetContext).size.height - 220,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: style.bottomSheetStyle.copyWith(color: Theme.of(context).cardColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Respostas',
                    style: textTheme.titleStyle.copyWith(
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
                itemCount: eventModel.responses.length,
                itemBuilder: (context, index) => ListTile(
                  tileColor: index % 2 == 0 ? null : Colors.grey.withAlpha(50),
                  title: Text(eventModel.responses[index].guestName),
                  trailing: Text(eventModel.responses[index].confirm
                      ? eventModel.confirmTextFormated
                      : eventModel.cancelTextFormated),
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
