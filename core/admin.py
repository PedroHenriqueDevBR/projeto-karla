from django.contrib import admin
from .models import *


class EventInlineAdmin(admin.TabularInline):
    model = Event
    readonly_fields = ('title', 'description', 'expiration_date')


class ResponseInlineAdmin(admin.TabularInline):
    model = Response
    readonly_fields = ('response_date', 'guest_name', 'confirm')


@admin.register(Person)
class PersonAdmin(admin.ModelAdmin):
    list_display = ('name', 'user')
    ordering = ('name',)
    search_fields = ('name',)
    inlines = [EventInlineAdmin]


@admin.register(Event)
class EventAdmin(admin.ModelAdmin):
    list_display = ('title', 'description', 'expiration_date')
    ordering = ('title',)
    search_fields = ('title',)
    inlines = [ResponseInlineAdmin]


@admin.register(Response)
class ResponseAdmin(admin.ModelAdmin):
    list_display = ('response_date', 'guest_name', 'confirm')
    ordering = ('response_date',)
    search_fields = ('guest_name',)
    list_filter = ('response_date', 'confirm')
