import 'package:flutter/material.dart';

import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';

class BottomButtonWidget extends StatelessWidget {
  VoidCallback onClick;
  final _style = ShowEventStyle();

  BottomButtonWidget({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Text('Salvar alterações'),
      style: _style.bottomButtonStyle,
    );
  }
}
