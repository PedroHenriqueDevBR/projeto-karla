import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:projeto_karla/src/pages/home/home_style.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/core/assets.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';

class EventCardWidget extends StatelessWidget {
  VoidCallback onClick;
  final EventModel event;
  final _radius = 8.0;
  final _assets = AppAssets();
  final _textTheme = AppTextTheme();
  final _style = HomeStyle();

  EventCardWidget({
    Key? key,
    required this.event,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 120,
                  decoration: _style.cardHeaderDecoration(
                    image: event.background ?? _assets.defaultImage,
                    isNetwork: event.background != null,
                  ),
                ),
                Container(
                  height: 120,
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
                        child: Text(
                          event.title,
                          style: _textTheme.titleStyle.copyWith(color: Colors.white),
                        ),
                        bottom: 8.0,
                        left: 8.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.description,
                    style: _textTheme.descriptionStyle,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Data limite: ${event.formatedDate}',
                        style: _textTheme.subtitleStyle,
                      ),
                      Text(
                        'Respostas: ${event.responses.length}',
                        style: _textTheme.subtitleStyle,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
