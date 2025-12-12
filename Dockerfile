FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# ВРЕМЕННО закомментируйте:
# RUN python manage.py collectstatic --noinput

EXPOSE $PORT

CMD ["sh", "-c", "python manage.py migrate && gunicorn ваш_проект.wsgi:application --bind 0.0.0.0:$PORT"]
