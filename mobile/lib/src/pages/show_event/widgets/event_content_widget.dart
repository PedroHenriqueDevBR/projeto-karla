import 'package:flutter/material.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';

import 'package:projeto_karla/src/shared/models/event_model.dart';

class EventContentWidget extends StatelessWidget {
  EventModel eventModel;
  final textTheme = AppTextTheme();

  EventContentWidget({required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eventModel.description.isNotEmpty ? eventModel.description : 'Evento sem descrição',
            style: textTheme.descriptionStyle.copyWith(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Data limite: ${eventModel.formatedDate}',
            style: textTheme.subtitleStyle.copyWith(fontSize: 14),
          ),
          SizedBox(height: 4.0),
          Text(
            'Respostas: ${eventModel.responses.length}',
            style: textTheme.subtitleStyle.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
    ;
  }
}
