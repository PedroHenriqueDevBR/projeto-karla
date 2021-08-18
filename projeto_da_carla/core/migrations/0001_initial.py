# Generated by Django 3.2.6 on 2021-08-18 02:32

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Event',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=150)),
                ('description', models.TextField(max_length=550)),
                ('avatar', models.CharField(blank=True, max_length=150, null=True)),
                ('background', models.CharField(blank=True, max_length=150, null=True)),
                ('confirm_text', models.CharField(blank=True, max_length=20, null=True)),
                ('cancel_text', models.CharField(blank=True, max_length=20, null=True)),
                ('expiration_date', models.CharField(blank=True, max_length=50, null=True)),
                ('password', models.CharField(default='', max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='Person',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=150)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='person', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='EventResponse',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('response_date', models.DateTimeField(auto_created=True, auto_now_add=True)),
                ('guest_name', models.CharField(max_length=150)),
                ('confirm', models.BooleanField(default=False)),
                ('event', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='responses', to='core.event')),
            ],
        ),
        migrations.AddField(
            model_name='event',
            name='person',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='events', to='core.person'),
        ),
    ]
