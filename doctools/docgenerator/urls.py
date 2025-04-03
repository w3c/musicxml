from django.contrib import admin
from django.urls import path, re_path
from spectools import views

urlpatterns = [
    path('', views.homepage, name='homepage'),
    path('<slug:schema_slug>-reference/', views.reference_homepage, name='reference_homepage'),
    path('<slug:schema_slug>-reference/data-types/', views.data_type_list, name='data_type_list'),
    path('<slug:schema_slug>-reference/data-types/<slug:slug>/', views.data_type_detail, name='data_type_detail'),
    path('<slug:schema_slug>-reference/elements/', views.element_list, name='element_list'),
    path('<slug:schema_slug>-reference/elements/<slug:slug>/', views.element_detail, name='element_detail'),
    path('<slug:schema_slug>-reference/element-tree/', views.element_tree, name='element_tree'),
    path('<slug:schema_slug>-reference/examples/', views.example_list, name='example_list'),
    path('<slug:schema_slug>-reference/examples/<slug:slug>/', views.example_detail, name='example_detail'),
    path('<slug:schema_slug>-reference/objects/', views.json_object_list, name='json_object_list'),
    path('<slug:schema_slug>-reference/objects/<slug:slug>/', views.json_object_detail, name='json_object_detail'),
    path('<slug:schema_slug>-schema.json', views.json_schema, name='json_schema'),
    path('concepts/', views.concept_list, name='concept_list'),
    path('concepts/<slug:slug>/', views.concept_detail, name='concept_detail'),
    path('comparisons/<slug:slug>/', views.format_comparison_detail, name='format_comparison_detail'),
    path('admin/', admin.site.urls),
    re_path(r'^.*$', views.static_page_or_collection_detail),
]
