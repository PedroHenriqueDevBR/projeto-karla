from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from core.models import EventResponse
from .serializers import *
from core.form_validator import validate_person_register_form


class LoginView(APIView):
    name = 'login-view'

    def get(self, request):
        eventResponse = EventResponse.objects.all()
        responseSerializer = ResponseSerializer(eventResponse, many=True)
        return Response(responseSerializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        print(request.data)
        return Response(data={'funcionou': 'Sim'}, status=status.HTTP_200_OK)


class RegisterView(APIView):
    name = 'register-view'

    def post(self, request):
        errors = validate_person_register_form(request.data)
        if len(errors) > 0:
            return Response({'errors': errors}, status=status.HTTP_400_BAD_REQUEST)
        return Response({'funcionou': 'Sim'})
