import 'package:flutter/material.dart';

class EventFormWidget extends StatelessWidget {
  GlobalKey<FormState> formKey;
  final TextEditingController txtDescription;
  final TextEditingController txtConfirmText;
  final TextEditingController txtCancelText;
  final TextEditingController txtDate;
  final VoidCallback onCancel;

  EventFormWidget({
    Key? key,
    required this.formKey,
    required this.txtDescription,
    required this.txtConfirmText,
    required this.txtCancelText,
    required this.txtDate,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: txtDescription,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Adicione informações sobre o evento';
              },
              minLines: 5,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Descrição',
                hintText: 'Descreva o evento',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: txtDate,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      final splitValue = value!.split('/');
                      if (value == null || value.isEmpty) return 'Informe a data limite para respostas';
                      if (splitValue.length != 3) return 'A data precisa ter o formato 00/00/0000';

                      final day = int.tryParse(splitValue[0]);
                      final month = int.tryParse(splitValue[1]);
                      final year = int.tryParse(splitValue[2]);
                      if (day == null || month == null || year == null)
                        return 'A data precisa ter o formato 00/00/0000';
                      final parseDate =
                          DateTime.tryParse('${splitValue[2]}-${splitValue[1]}-${splitValue[0]} 13:27:00');
                      if (parseDate == null) return 'Data inválida';
                      if (DateTime.now().compareTo(parseDate) != -1)
                        return 'A data não pode ser anterior ou igual à hoje';
                    },
                    decoration: InputDecoration(
                      labelText: 'Data',
                      hintText: 'Data limite para resposta',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showSelectDateDialog(context);
                  },
                  icon: Icon(Icons.date_range),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: txtConfirmText,
              decoration: InputDecoration(
                labelText: 'Texto confirmar',
                hintText: 'Texto para confirmar presença',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: txtCancelText,
              decoration: InputDecoration(
                labelText: 'Texto cancelar',
                hintText: 'Texto para cancelar presença',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextButton(onPressed: this.onCancel, child: Text('Cancelar edição')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectDateDialog(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (date != null) txtDate.text = _formatedDate(date);
  }

  String _formatedDate(DateTime dateTime) {
    return '${formatDateInfo(dateTime.day)}/${formatDateInfo(dateTime.month)}/${dateTime.year}';
  }

  String formatDateInfo(int value) {
    if (value < 10) return '0$value';
    return '$value';
  }
}
