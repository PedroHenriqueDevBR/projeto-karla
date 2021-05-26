from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from .models import *
from pdb import set_trace


def login_page(request):
    username = ''
    password = ''
    if request.method == 'POST':
        username = request.POST.get('username_login')
        password = request.POST.get('password_login')

        user = authenticate(request, username=username, password=password)

        if user is None:
            messages.error(request, 'Usuário não cadastrado')
            messages.error(request, 'Verifique as suas credenciais')
        else:
            login(request, user)
            return redirect('dashboard')

    return render(request, 'login.html', {'username': username, 'password': password})


def logout_page(request):
    logout(request)
    return redirect('login')


def user_register_page(request):
    name = ''
    username = ''
    password = ''
    password_repeat = ''
    if request.method == 'POST':
        name = request.POST.get('name')
        username = request.POST.get('username')
        password = request.POST.get('password')
        password_repeat = request.POST.get('password-repeat')

        if password != password_repeat:
            messages.error(request, 'Senhas diferentes ao se cadastrar, tente novamente')
        elif len(password) < 8:
            messages.error(request, 'A senha deve conter pelo menos 8 caracteres')
        else:
            user_registered = User.objects.filter(username=username)
            if len(user_registered) == 0:
                user = User.objects.create_user(
                    username=username,
                    first_name=name,
                    password=password,
                    email='mail@mail.com'
                )
                person = Person()
                person.name = name
                person.user = user
                person.save()
                return redirect('login')
            else:
                messages.error(request, 'Username já cadastrado')

    return render(request, 'login.html', {'name': name, 'username': username, 'password': password})


@login_required(login_url='login')
def dashboard_page(request):
    person = request.user.person
    events = person.events.all()

    if request.method == 'POST':
        title = request.POST.get('title')
        description = request.POST.get('description')
        limit_date = request.POST.get('limit-date')

        event = Event()
        event.title = title
        event.description = description
        event.expiration_date = limit_date
        event.person = person
        event.save()
        return redirect('dashboard')
    return render(request, 'index.html', {'person': person, 'events': events})


def event_page(request, pk, title):
    is_owner = False
    event = Event.objects.filter(pk=pk)

    if len(event) > 0:
        event = event[0]
        responses = []
        try:
            person = request.user.person
            is_owner = event.person == person
        except:
            pass

        if request.method == 'POST' and is_owner:
            title = request.POST.get('title')
            description = request.POST.get('description')
            background = request.POST.get('background')
            confirm_text = request.POST.get('confirm-text')
            cancel_text = request.POST.get('cancel-text')
            person = request.user.person

            event.title = title
            event.description = description
            event.person = person
            if len(background) > 0:
                event.background = background
            if len(confirm_text) > 0:
                event.confirm_text = confirm_text
            if len(cancel_text) > 0:
                event.cancel_text = cancel_text
            event.save()
        if is_owner:
            responses = event.responses.all()
        return render(request, 'event.html', {'event': event, 'is_owner': is_owner, 'responses': responses,})
    else:
        return redirect('login')

def confirm(request, pk, name):
    event = Event.objects.filter(pk=pk)
    if len(event) == 0:
        return redirect('login')

    response = Response()
    response.guest_name = name
    response.confirm = True
    response.event = event[0]
    response.save()
    return render(request, 'thank.html')

def cancel(request, pk, name):
    event = Event.objects.filter(pk=pk)
    if len(event) == 0:
        return redirect('login')

    response = Response()
    response.guest_name = name
    response.confirm = True
    response.event = event[0]
    response.save()
    return render(request, 'thank.html')
