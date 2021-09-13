from django.contrib import admin
from django.urls import path
from django.urls.conf import include
from core.views import *
from rest_framework_simplejwt import views as jwt_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', dashboard_page, name='dashboard'),
    path('login/', login_page, name='login'),
    path('logout/', logout_page, name='logout'),
    path('user/register', user_register_page, name='register-person'),
    path('evento/<int:pk>/confirm/<str:name>', confirm, name='confirm'),
    path('evento/<int:pk>/cancel/<str:name>', cancel, name='cancel'),
    path('evento/<int:pk>/<str:title>', event_page, name='event'),

    path('api/token/', jwt_views.TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', jwt_views.TokenRefreshView.as_view(), name='token_refresh'),
    
    path('api/v1/', include('api_v1.urls')),

]
