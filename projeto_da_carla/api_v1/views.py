from rest_framework import status
from rest_framework import response
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from .serializers import *
from core.form_validator import *
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
                expiration_date = data['expiration_date'] if 'expiration_date' in data else None,
                password =  data['password'] if 'password' in data else '',
                person = request.user.person,
            )

            event.save()
            serializer = EventSerializer(event)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        except:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class EventView(APIView):
    name = 'event-view'

    def get(self, request, pk):
        try:
            event = Event.objects.get(pk=pk)
            serializer = EventSerializer(event)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except:
            return Response(status=status.HTTP_404_NOT_FOUND)


class EventEditView(APIView):
    name = 'event-edit-view'
    permission_classes = [IsAuthenticated]

    def put(self, request, pk):
        try:
            event = Event.objects.get(pk=pk)
            if event.person.id != request.user.person.id:
                return Response({'errors': ['access denied']}, status=status.HTTP_401_UNAUTHORIZED)
        except:
            return Response({'errors': ['event not found']}, status=status.HTTP_404_NOT_FOUND)

        data = request.data
        form_errors = event_register_validate_form_or_errors(data)        
        if len(form_errors) > 0:
            return Response({'errors': form_errors}, status=status.HTTP_400_BAD_REQUEST)

        event.title = data['title']
        event.description = data['description'] if 'description' in data else 'Sem descrição'
        event.avatar =  data['avatar'] if 'avatar' in data else None
        event.background =  data['background'] if 'background' in data else None
        event.confirm_text =  data['confirm_text'] if 'confirm_text' in data else None
        event.cancel_text =  data['cancel_text'] if 'cancel_text' in data else None
        event.expiration_date = data['expiration_date'] if 'expiration_date' in data else None
        event.password =  data['password'] if 'password' in data else ''
        event.save()
        serializer = EventSerializer(event)
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def delete(self, request, pk):
        try:
            event = Event.objects.get(pk=pk)
            if event.person.id != request.user.person.id:
                return Response({'errors': ['access denied']}, status=status.HTTP_401_UNAUTHORIZED)
            event.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        except:
            return Response({'errors': ['event not found']}, status=status.HTTP_404_NOT_FOUND)


class EventResponseListView(APIView):
    name = 'event-response-list-view'
    permission_classes = [IsAuthenticated]
    
    def get(self, request, event_pk):
        try:
            try:
                event = Event.objects.get(pk=event_pk)
                if event.person.id != request.user.person.id:
                    return Response({'errors': ['access denied']}, status=status.HTTP_401_UNAUTHORIZED)
            except:
                return Response({'errors': ['Event not found']}, status=status.HTTP_404_NOT_FOUND)
            responses = event.responses.all()
            serializer = ResponseSerializer(responses, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class EventResponseAddView(APIView):
    name = 'event-response-add-view'

    def post(self, request, event_pk):
        data = request.data
        form_errors = response_register_validate_form_or_errors(data)
        if len(form_errors) > 0:
            return Response({'errors': form_errors}, status=status.HTTP_400_BAD_REQUEST)
        try:
            event = Event.objects.get(pk=event_pk)
        except:
            return Response({'errors': ['event not found']}, status=status.HTTP_404_NOT_FOUND)
        responseData = EventResponse(
            guest_name = data['guest_name'],
            confirm = data['confirm'],
            event = event
        )
        try:
            responseData.save()
            serializer = ResponseSerializer(responseData)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class EventResponseDeleteView(APIView):
    name = 'event-response-delete-view'
    permission_classes = [IsAuthenticated]

    def delete(self, request, event_pk, response_pk):
        try:
            response = EventResponse.objects.get(pk=response_pk)
            if response.event.person.id != request.user.person.id or response.event.id != event_pk:
                return Response({'errors': ['access denied']}, status=status.HTTP_401_UNAUTHORIZED)
            response.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
        except:
            return Response({'errors': ['event not found']}, status=status.HTTP_404_NOT_FOUND)