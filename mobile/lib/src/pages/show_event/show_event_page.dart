import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projeto_karla/src/pages/show_event/stores/show_event_store.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/bottom_button_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/bottom_navigation_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/event_content_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/event_form_widget.dart';
import 'package:projeto_karla/src/pages/show_event/widgets/header_widget.dart';
import 'package:projeto_karla/src/shared/models/event_model.dart';
import 'package:projeto_karla/src/shared/repositories/event_repository.dart';
import 'package:projeto_karla/src/shared/repositories/user_repository.dart';
import 'package:projeto_karla/src/shared/services/app_preferences_service.dart';
import 'package:projeto_karla/src/shared/services/http_client_service.dart';

class ShowEventPage extends StatefulWidget {
  EventModel? eventModel;
  ShowEventPage({this.eventModel});
  @override
  _ShowEventPageState createState() => _ShowEventPageState();
}

class _ShowEventPageState extends State<ShowEventPage> {
  late ShowEventStore _store;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    this._store = ShowEventStore(
      context: context,
      userRepository: UserRepository(
        client: HttpClientService(),
        appData: AppPreferenceService(),
      ),
      eventRepository: EventRepository(
        client: HttpClientService(),
        appData: AppPreferenceService(),
      ),
    );
    _store.initEvent(widget.eventModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
      ),
      bottomNavigationBar: Observer(
        builder: (context) => _store.editing
            ? BottomButtonWidget(onClick: () {
                if (formKey.currentState!.validate()) {
                  _store.save();
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
