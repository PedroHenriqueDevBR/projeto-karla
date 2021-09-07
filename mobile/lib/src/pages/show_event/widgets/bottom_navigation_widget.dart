import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:projeto_karla/src/shared/models/response_model.dart';

class BottomNavigationWidget extends StatelessWidget {
  final TextEditingController txtResponse;
  final textTheme = AppTextTheme();
  final style = ShowEventStyle();
  EventModel eventModel;
  VoidCallback editOption;
  Function onConfirmResponse;
  Function onDeleteResponse;

  BottomNavigationWidget({
    Key? key,
    required this.txtResponse,
    required this.eventModel,
    required this.editOption,
    required this.onConfirmResponse,
    required this.onDeleteResponse,
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
          label: 'Respostas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_outlined),
          label: 'Editar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Novo',
        ),
      ],
    );
  }

  void showResponses(BuildContext context) {
    asuka.showBottomSheet(
      (bottomSheetContext) => SafeArea(
        top: true,
        child: Container(
          height: MediaQuery.of(bottomSheetContext).size.height - 35,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
                  itemBuilder: (context, index) {
                    ResponseModel response = eventModel.responses[index];
                    return ListTile(
                      tileColor: index % 2 == 0 ? null : Colors.grey.withAlpha(50),
                      title: Text(response.guestName),
                      subtitle: Text(response.confirm ? eventModel.confirmTextFormated : eventModel.cancelTextFormated),
                      leading: response.confirm ? Icon(Icons.check) : Icon(Icons.close),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.pop(bottomSheetContext);
                          confirmRemoveResponse(response);
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: txtResponse,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Campo obrigatório';
                    if (value.length < 3) return 'Digite no mínimo 3 caracteres';
                  },
                  decoration: InputDecoration(
                    labelText: 'Nome do convidado',
                    hintText: 'Digite o nome do convidado',
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onConfirmResponse(false);
                        Navigator.pop(dialogContext);
                      },
                      child: Text(eventModel.cancelTextFormated),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onConfirmResponse(true);
                        Navigator.pop(dialogContext);
                      },
                      child: Text(eventModel.confirmTextFormated),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
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

  void confirmRemoveResponse(ResponseModel response) {
    asuka.showDialog(
      builder: (dialogContext) => AlertDialog(
        title: Text('Remover resposta'),
        content: Text('Atenção: Deletar a resposta de ${response.guestName}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              onDeleteResponse(response);
              Navigator.pop(dialogContext);
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
