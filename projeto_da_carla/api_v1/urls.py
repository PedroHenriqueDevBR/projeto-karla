from .views import *
from django.urls import path

urlpatterns = [
    path('register', RegisterView.as_view(), name=RegisterView.name),
    path('events', EventListView.as_view(), name=EventListView.name),
]