from rest_framework import serializers, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from core.models import EventResponse
from .serializers import *
from core.form_validator import event_register_validate_form_or_errors, person_register_validate_form_or_errors
from core.views import create_user_or_errors


class RegisterView(APIView):
    name = 'register-view'

    def post(self, request):
        data = request.data
        form_errors = person_register_validate_form_or_errors(data)
        if len(form_errors) > 0:
            return Response({'errors': form_errors}, status=status.HTTP_400_BAD_REQUEST)
        create_user_errors = create_user_or_errors(data)
        if len(create_user_errors) > 0:
            return Response({'errors': create_user_errors}, status=status.HTTP_400_BAD_REQUEST)
        return Response(status=status.HTTP_201_CREATED)


class EventListView(APIView):
    name = 'event-list-view'
    permission_classes = [IsAuthenticated]

    def get(self, request):
        events = request.user.person.events.all()
        event_serializer = EventSerializer(events, many=True)
        return Response(event_serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        data = request.data
        form_errors = event_register_validate_form_or_errors(data)
        if len(form_errors) > 0:
            return Response({'errors': form_errors}, status=status.HTTP_400_BAD_REQUEST)

        try:
            event = Event(
                title = data['title'],
                description = data['description'] if 'description' in data else 'Sem descrição',
                avatar =  data['avatar'] if 'avatar' in data else None,
                background =  data['background'] if 'background' in data else None,
                confirm_text =  data['confirm_text'] if 'confirm_text' in data else None,
                cancel_text =  data['cancel_text'] if 'cancel_text' in data else None,
                expiration_date =  data['expiration_date'] if 'expiration_date' in data else None,
                password =  data['password'] if 'password' in data else None,
                person = request.user.person,
            )

            serializer = EventSerializer(event)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
