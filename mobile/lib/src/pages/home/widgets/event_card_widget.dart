import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';

class EventCardWidget extends StatelessWidget {
  final _radius = 8.0;
  EventModel event;
  final _defaultImage =
      'https://images.pexels.com/photos/1263986/pexels-photo-1263986.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260';

  EventCardWidget({
    required this.event,
  });
  AppTextTheme _textTheme = AppTextTheme();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      event.background ?? _defaultImage,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_radius),
                    topRight: Radius.circular(_radius),
                  ),
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
            padding: EdgeInsets.all(8.0),
            child: Column(
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
    );
  }
}
