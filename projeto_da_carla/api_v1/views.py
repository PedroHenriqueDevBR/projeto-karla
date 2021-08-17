from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from core.models import EventResponse
from .serializers import *
from core.form_validator import validate_person_register_form_or_errors
from core.views import create_user_or_errors


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
        data = request.data
        form_errors = validate_person_register_form_or_errors(data)
        if len(form_errors) > 0:
            return Response({'errors': form_errors}, status=status.HTTP_400_BAD_REQUEST)
        create_user_errors = create_user_or_errors(data)
        if len(create_user_errors) > 0:
            return Response({'errors': create_user_errors}, status=status.HTTP_400_BAD_REQUEST)
        return Response(status=status.HTTP_200_OK)
