import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_karla/src/pages/show_event/stores/show_event_store.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/bottom_button_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/bottom_navigation_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/event_content_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/event_form_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/header_widget.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';

class ShowEventPage extends StatefulWidget {
  EventModel? eventModel;
  ShowEventPage({this.eventModel});
  @override
  _ShowEventPageState createState() => _ShowEventPageState();
}

class _ShowEventPageState extends State<ShowEventPage> {
  final _store = ShowEventStore();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _store.initEvent(widget.eventModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Observer(
              builder: (context) => HeaderWidget(
                imageUrl: _store.imageUrl,
                txtTitle: _store.txtTitle,
                txtImage: _store.txtImageUrl,
                edit: _store.editing,
                onSaveImage: _store.changeBackgroundImage,
                onShare: _store.shareEvent,
              ),
            ),
            Observer(
              builder: (context) => _store.editing
                  ? EventFormWidget(
                      formKey: formKey,
                      txtDescription: _store.txtDescription,
                      txtConfirmText: _store.txtConfirmText,
                      txtCancelText: _store.txtCancelText,
                      txtDate: _store.txtDate,
                      onCancel: _store.toggleEdit,
                    )
                  : EventContentWidget(
                      eventModel: _store.event,
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (context) => _store.editing
            ? BottomButtonWidget(onClick: () {
                if (formKey.currentState!.validate()) {
                  _store.toggleEdit();
                }
              })
            : BottomNavigationWidget(
                eventModel: _store.event,
                editOption: _store.toggleEdit,
              ),
      ),
    );
  }
}
