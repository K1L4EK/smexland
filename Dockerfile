# 1. Базовый образ
FROM python:3.11-alpine

# 2. Устанавливаем системные зависимости для PostgreSQL
RUN apk update \
    && apk add --no-cache \
        postgresql-dev \
        gcc \
        python3-dev \
        musl-dev \
        libffi-dev \
        jpeg-dev \
        zlib-dev

# 3. Устанавливаем рабочую директорию
WORKDIR /app

# 4. Устанавливаем переменные окружения
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

# 5. Копируем и устанавливаем зависимости
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# 6. Копируем весь проект
COPY . .

# 7. Создаем статические файлы (опционально)
# RUN python manage.py collectstatic --noinput --clear

# 8. Запускаем миграции и сервер (для Railway лучше разделить)
CMD ["sh", "-c", "python manage.py migrate && gunicorn your_project_name.wsgi --bind 0.0.0.0:$PORT"]

CMD python manage.py migrate && gunicorn smexland2.wsgi:application --bind 0.0.0.0:$PORT