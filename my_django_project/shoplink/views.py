from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection

def index(request):
    return HttpResponse("Hello, world. You're at the polls index.")



def display_sellers_table_data(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM sellers")  # Remplacez 'nom_de_votre_table' par le nom de votre table
        table_sellers_data = cursor.fetchall()

    return render(request, 'table_sellers_template.html', {'table_sellers_data': table_sellers_data})


def display_buyers_table_data(request):
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM buyers")  # Remplacez 'nom_de_votre_table' par le nom de votre table
        table_buyers_data = cursor.fetchall()

    return render(request, 'table_buyers_template.html', {'table_buyers_data': table_buyers_data})
