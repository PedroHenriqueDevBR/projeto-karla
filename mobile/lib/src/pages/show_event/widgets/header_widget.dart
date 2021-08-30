import 'package:flutter/material.dart';
import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/core/assets.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:asuka/asuka.dart' as asuka;

class HeaderWidget extends StatelessWidget {
  final EventModel event;
  final _style = ShowEventStyle();
  final _assets = AppAssets();
  final _textTheme = AppTextTheme();
  final txtTitle;
  bool edit;

  HeaderWidget({
    required this.event,
    required this.txtTitle,
    this.edit = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _imageHeader(),
        _internalGradient(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            width: size.width,
            child: this.edit ? _inputTitle(context, size) : _information(),
          ),
        ),
      ],
    );
  }

  Widget _imageHeader() {
    return Container(
      width: double.maxFinite,
      height: 220,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            event.background ?? _assets.defaultImage,
          ),
        ),
      ),
    );
  }

  Widget _internalGradient({required Widget child}) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black.withAlpha(150)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            child: child,
            bottom: 0.0,
          ),
        ],
      ),
    );
  }

  Widget _inputTitle(BuildContext context, Size size) {
    return Container(
      width: double.maxFinite,
      height: 175,
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Wrap(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: showChangeImageDialog,
                    icon: Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                    ),
                  ),
                  decoration: _style.iconButtonStyle,
                ),
              ],
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo obrigatório';
            },
            decoration: InputDecoration(
              labelText: 'Titulo',
              hintText: 'Digite o titulo do evento',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _information() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              event.title.isNotEmpty ? event.title : 'Titulo do evento',
              style: _textTheme.titleStyle.copyWith(color: Colors.white),
            ),
          ),
          Container(
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
            decoration: _style.iconButtonStyle,
          ),
        ],
      ),
    );
  }

  void showChangeImageDialog() {
    asuka.showDialog(
      builder: (dialogContext) => AlertDialog(
        title: Text('Capa do evento'),
        content: Container(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'URL',
                  hintText: 'Digite a url da imagem',
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
