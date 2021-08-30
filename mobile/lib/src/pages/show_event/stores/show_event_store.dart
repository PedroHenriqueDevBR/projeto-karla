import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:projeto_karla/src/shared/models/response_model.dart';

part 'show_event_store.g.dart';

class ShowEventStore = _ShowEventStore with _$ShowEventStore;

abstract class _ShowEventStore with Store {
  final textTheme = AppTextTheme();
  final style = ShowEventStyle();
  // ===
  final txtTitle = TextEditingController();
  final txtDescription = TextEditingController();
  final txtDate = TextEditingController();
  final txtConfirmText = TextEditingController();
  final txtCancelText = TextEditingController();

  @observable
  bool editing = false;

  @observable
  EventModel event = EventModel.empty();

  @observable
  String imageUrl = '';

  void initEvent(EventModel? eventArg) {
    this.event = eventArg != null ? eventArg : EventModel.empty();
    event.responses.addAll([
      ResponseModel(guestName: 'Pedro', confirm: true, responseDate: DateTime.now()),
      ResponseModel(guestName: 'Pedro', confirm: false, responseDate: DateTime.now()),
      ResponseModel(guestName: 'Pedro', confirm: true, responseDate: DateTime.now()),
      ResponseModel(guestName: 'Pedro', confirm: true, responseDate: DateTime.now()),
      ResponseModel(guestName: 'Pedro', confirm: false, responseDate: DateTime.now()),
    ]);
  }

  @action
  void changeBackgroundImage(String url) {
    this.event.background = url;
  }

  bool _imageIsValid(String image) {
    if (!image.contains('http')) return false;
    return true;
  }

  @action
  void toggleEdit() {
    editing = !editing;
  }
}
