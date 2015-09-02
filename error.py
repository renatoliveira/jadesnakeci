# -*- coding: utf-8 -*-
from bottle import *

def custom_error(error):
    # print(error)
    return template('templates/error.tpl', code=error.status_code, error_info=error)

def jade_error(error):
    return template('templates/error.tpl', code=error.status_code, error_info=error)

handler = {
    304: custom_error,
    404: custom_error,
    405: custom_error,
    500: custom_error,
    904: jade_error,
    905: jade_error,
}