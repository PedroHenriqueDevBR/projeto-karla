# Generated by Django 3.2.3 on 2021-05-26 19:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_auto_20210526_1421'),
    ]

    operations = [
        migrations.AlterField(
            model_name='response',
            name='response_date',
            field=models.DateTimeField(auto_created=True, auto_now_add=True),
        ),
    ]
