import 'package:flutter/material.dart';
import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/core/assets.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';

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
        _image(),
        _internalShadow(
          child: _content(size: size, context: context),
        ),
      ],
    );
  }

  Widget _image() {
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

  Widget _internalShadow({required Widget child}) {
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

  Widget _content({required Size size, required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: size.width,
      color: edit ? Theme.of(context).cardColor : null,
      child: this.edit ? _inputTitle(context, size) : _information(),
    );
  }

  Widget _inputTitle(BuildContext context, Size size) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Titulo',
        hintText: 'Digite o titulo do evento',
      ),
    );
  }

  Widget _information() {
    return Row(
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
            icon: Icon(Icons.share),
            color: Colors.white,
          ),
          decoration: _style.iconButtonStyle,
        ),
      ],
    );
  }
}
