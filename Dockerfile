FROM python:3.11-slim

# Установите системные зависимости для psycopg2
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копируем и устанавливаем зависимости
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем проект
COPY . .

# Собираем статику
RUN python manage.py collectstatic --noinput

# Запускаем миграции и Gunicorn
CMD sh -c "python manage.py migrate && gunicorn ваш_проект.wsgi:application --bind 0.0.0.0:$PORT"
