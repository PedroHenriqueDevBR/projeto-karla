import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:projeto_karla/src/pages/show_event/show_event_style.dart';
import 'package:projeto_karla/src/shared/core/app_text_theme.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:share/share.dart';

part 'show_event_store.g.dart';

class ShowEventStore = _ShowEventStore with _$ShowEventStore;

abstract class _ShowEventStore with Store {
  final textTheme = AppTextTheme();
  final style = ShowEventStyle();
  // ===
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtConfirmText = TextEditingController();
  TextEditingController txtCancelText = TextEditingController();
  TextEditingController txtImageUrl = TextEditingController();

  @observable
  bool editing = false;

  @observable
  String imageUrl = '';

  @observable
  EventModel event = EventModel.empty();

  @action
  void changeBackgroundImage() {
    if (!_imageIsValid(txtImageUrl.text)) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('A URL da imagem não é válida'));
      return;
    }
    this.imageUrl = txtImageUrl.text;
  }

  @action
  void toggleEdit() => editing = !editing;

  @action
  changeCurrentEvent(EventModel value) => this.event = value;

  void initEvent(EventModel? eventArg) {
    if (eventArg != null) {
      this.txtTitle.text = eventArg.title;
      this.txtDescription.text = eventArg.description;
      this.txtDate.text = eventArg.formatedDate;
      this.txtConfirmText.text = eventArg.confirmTextFormated;
      this.txtCancelText.text = eventArg.cancelTextFormated;
      this.imageUrl = eventArg.background ?? '';
      this.changeCurrentEvent(eventArg);
      event.responses.addAll(eventArg.responses);
    }
  }

  bool _imageIsValid(String image) {
    if (!image.contains('http')) return false;
    return true;
  }

  void shareEvent() {
    if (event.id == null) {
      asuka.showSnackBar(asuka.AsukaSnackbar.message('Evento não salvo no sistema'));
      return;
    }
    Share.share(
      'http://localhost:8000/evento/${event.id}/${event.title.replaceAll(' ', '')}',
      subject: 'Look what I made!',
    );
  }
}
