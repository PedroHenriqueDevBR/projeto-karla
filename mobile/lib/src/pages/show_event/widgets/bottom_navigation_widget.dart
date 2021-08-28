import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatelessWidget {
  VoidCallback visualizeOption;
  VoidCallback editOption;
  VoidCallback addOption;

  BottomNavigationWidget({
    Key? key,
    required this.visualizeOption,
    required this.editOption,
    required this.addOption,
  }) : super(key: key);

  void _selectOption(int option) {
    if (option == 0)
      visualizeOption();
    else if (option == 1)
      editOption();
    else if (option == 2) addOption();
  }

  @override
  Widget build(BuildContext context) {
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
}
