from .views import *
from django.urls import path

urlpatterns = [
    path('', LoginView.as_view(), name=LoginView.name),
    path('register', RegisterView.as_view(), name=RegisterView.name),
]