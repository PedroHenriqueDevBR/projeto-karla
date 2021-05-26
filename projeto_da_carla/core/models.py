from django.db import models
from django.contrib.auth.models import User


class Person(models.Model):
    name = models.CharField(max_length=150)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='person')


class Event(models.Model):
    title = models.CharField(max_length=150)
    description = models.TextField(max_length=550)
    avatar = models.CharField(max_length=150)
    background = models.CharField(max_length=150)
    confirm_text = models.CharField(max_length=20)
    cancel_text = models.CharField(max_length=20)
    expiration_date = models.DateField()
    person = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='events')


class Response(models.Model):
    response_date = models.DateTimeField(auto_created=True)
    guest_name = models.CharField(max_length=150)
    response_text = models.CharField(max_length=150)
    event = models.ForeignKey(Event, on_delete=models.CASCADE, related_name='responses')
