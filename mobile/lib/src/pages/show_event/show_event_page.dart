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
  final store = ShowEventStore();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    store.initEvent(widget.eventModel);
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
                event: store.event,
                txtTitle: store.txtTitle,
                edit: store.editing,
              ),
            ),
            Observer(
              builder: (context) => store.editing
                  ? EventFormWidget(
                      formKey: formKey,
                      txtDescription: store.txtDescription,
                      txtDate: store.txtDate,
                      txtConfirmText: store.txtConfirmText,
                      txtCancelText: store.txtCancelText,
                    )
                  : EventContentWidget(
                      eventModel: store.event,
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (context) => store.editing
            ? BottomButtonWidget(onClick: store.toggleEdit)
            : BottomNavigationWidget(
                eventModel: store.event,
                editOption: store.toggleEdit,
              ),
      ),
    );
  }
}
