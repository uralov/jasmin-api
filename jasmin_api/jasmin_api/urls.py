from django.conf.urls import include, url
from django.contrib import admin

from rest_framework.routers import DefaultRouter

from rest_api import views

router = DefaultRouter()
router.register(r'groups', views.GroupViewSet, base_name='groups')

urlpatterns = [
    url(r'^$', views.TestView.as_view()),
    url(r'^api/', include(router.urls)),
    url(r'^admin/', include(admin.site.urls)),
]

