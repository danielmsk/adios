from django.shortcuts import render
from .util import web
# from django.http import HttpResponse


def index(request):
    data = {}
    data['page_title'] = "창작공간 수풀"
    return web.render(request, 'index.html', data)
