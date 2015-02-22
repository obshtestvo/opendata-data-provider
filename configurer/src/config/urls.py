from django.conf.urls import patterns, include, url
from .views.settings import SettingsView

urlpatterns = patterns('',
    url(r'^$', SettingsView.as_view(), name='settings'),
)