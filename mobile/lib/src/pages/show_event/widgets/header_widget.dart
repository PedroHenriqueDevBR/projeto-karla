import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/core/assets.dart';

class HeaderWidget extends StatelessWidget {
  final String imageUrl;
  TextEditingController txtTitle;
  TextEditingController txtImage;
  final _style = ShowEventStyle();
  final _assets = AppAssets();
  final _textTheme = AppTextTheme();
  bool edit;
  Function onSaveImage;
  VoidCallback onShare;

  HeaderWidget({
    Key? key,
    required this.imageUrl,
    required this.txtTitle,
    required this.txtImage,
    this.edit = false,
    required this.onSaveImage,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        _imageHeader(),
        _internalGradient(
          context: context,
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
      decoration: _style.cardHeaderDecoration(
        image: imageUrl.isNotEmpty ? imageUrl : _assets.defaultImage,
        isNetwork: imageUrl.isNotEmpty,
      ),
    );
  }

  Widget _internalGradient({
    required Widget child,
    required BuildContext context,
  }) {
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
            child: Container(
              decoration: _style.backButtonStyle,
              child: BackButton(color: Colors.white),
            ),
            top: 12.0,
            left: 12.0,
          ),
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
            controller: txtTitle,
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
              txtTitle.text.isNotEmpty ? txtTitle.text : 'Titulo do evento',
              style: _textTheme.titleStyle.copyWith(color: Colors.white),
            ),
          ),
          Container(
            child: IconButton(
              onPressed: this.onShare,
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
                controller: txtImage,
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
                      onPressed: () {
                        this.onSaveImage();
                        Navigator.pop(dialogContext);
                      },
                      child: Text('Salvar'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(
                        'Cancelar',
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
