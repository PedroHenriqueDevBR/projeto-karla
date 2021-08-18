from .views import *
from django.urls import path

urlpatterns = [
    path('register', RegisterView.as_view(), name=RegisterView.name),
    path('events', EventListView.as_view(), name=EventListView.name),
    path('events/show/<int:pk>', EventView.as_view(), name=EventView.name),
    path('events/<int:pk>', EventEditView.as_view(), name=EventEditView.name),
    path('events/<int:event_pk>/responses', EventResponseListView.as_view(), name=EventResponseListView.name),
    path('events/<int:event_pk>/responses/add', EventResponseAddView.as_view(), name=EventResponseAddView.name),
    path('events/<int:event_pk>/responses/del/<int:response_pk>', EventResponseDeleteView.as_view(), name=EventResponseDeleteView.name),
]
