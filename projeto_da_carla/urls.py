from django.contrib import admin
from django.urls import path
from core.views import *

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', dashboard_page, name='dashboard'),
    path('login/', login_page, name='login'),
    path('logout/', logout_page, name='logout'),
    path('user/register', user_register_page, name='register-person'),
    path('evento/<int:pk>/confirm/<str:name>', confirm, name='confirm'),
    path('evento/<int:pk>/cancel/<str:name>', cancel, name='cancel'),
    path('evento/<int:pk>/<str:title>', event_page, name='event'),
]
