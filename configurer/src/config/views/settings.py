from os.path import join
from django.views.generic.base import View
from restful.decorators import restful_view_templates
from django import forms
from django.conf import settings
from config.storage.file import read, write
configpath = join(settings.BASE_DIR, '../config.json')

@restful_view_templates
class SettingsView(View):
    def get(self, request):
        config = read(configpath)
        return {
            "form": Form(data={
                "api_token": config["ckan"]["api_token"],
                "organization": config["details"]["organization"],
                "dataset_name": config["details"]["name"],
                "dataset_title": config["details"]["title"],
            })
        }

    def post(self, request):
        config = {
            "ckan": {},
            "details": {},
        }
        form = Form(data=request.params)
        if form.is_valid:
            config["details"]["organization"] = form.cleaned_data["organization"]
            config["details"]["dataset_name"] = form.cleaned_data["dataset_name"]
            config["details"]["dataset_title"] = form.cleaned_data["dataset_title"]
            config["ckan"]["api_token"] = form.cleaned_data["api_token"]
            write(config)


class Form(forms.Form):
    api_token = forms.CharField(label='API token', max_length=100)
    organization = forms.CharField(label='Организация', max_length=100)
    dataset_name = forms.CharField(label='Име на набора от данни', max_length=100)
    dataset_title = forms.CharField(label='Част от адреса', max_length=100)