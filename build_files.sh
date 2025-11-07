#!/bin/bash

# Instalar dependenciass
pip install -r requirements.txt

# Recolectar archivos estáticos
python manage.py collectstatic --no-input --clear
