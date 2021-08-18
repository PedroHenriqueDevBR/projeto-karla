from django.db import models
from django.contrib.auth.models import User

class Person(models.Model):
    name = models.CharField(max_length=150)
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='person')


class Event(models.Model):
    title = models.CharField(max_length=150)
    description = models.TextField(max_length=550)
    avatar = models.CharField(max_length=150, null=True, blank=True)
    background = models.CharField(max_length=150, null=True, blank=True)
    confirm_text = models.CharField(max_length=20, null=True, blank=True)
    cancel_text = models.CharField(max_length=20, null=True, blank=True)
    expiration_date = models.CharField(max_length=50, null=True, blank=True)
    password = models.CharField(max_length=50, default='')
    person = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='events')


class EventResponse(models.Model):
    response_date = models.DateTimeField(auto_created=True, auto_now_add=True)
    guest_name = models.CharField(max_length=150)
    confirm = models.BooleanField(default=False)
    event = models.ForeignKey(Event, on_delete=models.CASCADE, related_name='responses')
