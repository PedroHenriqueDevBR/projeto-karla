from django.db.models import fields
from rest_framework.serializers import ModelSerializer
from core.models import *

class TrackSerializer(ModelSerializer):
    class Meta:
        model = EventResponse
        fields = ['id', 'response_date', 'guest_name', 'confirm']

class EventSerializer(ModelSerializer):
    responses = TrackSerializer(many=True, read_only=True)
    class Meta:
        model = Event
        fields = [
            'id',
            'title',
            'description',
            'avatar',
            'background',
            'confirm_text',
            'cancel_text',
            'expiration_date',
            'password',
            'person',
            'responses',
        ]

class ResponseSerializer(ModelSerializer):
    class Meta:
        model = EventResponse
        fields = [
            'id',
            'response_date',
            'guest_name',
            'confirm',
            'event',
        ]