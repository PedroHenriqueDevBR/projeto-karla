from django.db.models import fields
from rest_framework.serializers import ModelSerializer
from core.models import *

class EventSerializer(ModelSerializer):
    class Meta:
        model = Event
        fields = [
            'title',
            'description',
            'avatar',
            'background',
            'confirm_text',
            'cancel_text',
            'expiration_date',
            'password',
            'person',
        ]

class ResponseSerializer(ModelSerializer):
    class Meta:
        model = EventResponse
        fields = [
            'response_date',
            'guest_name',
            'confirm',
            'event',
        ]