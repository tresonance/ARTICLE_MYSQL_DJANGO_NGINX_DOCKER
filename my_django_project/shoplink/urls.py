from django.urls import path

from . import views

urlpatterns = [
    path("", views.display_sellers_table_data, name="index"),
    path("sellers/", views.display_sellers_table_data, name="sellers"),
    path("buyers/", views.display_buyers_table_data, name="buyers"),
]