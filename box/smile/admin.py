from django.contrib import admin
from .models import Product # Импортируем модель которую хотим зарегестрировать в админке

# MyModel имеется ввиду любая ваша модель...

@admin.register(Product)
class MyModelAdmin(admin.ModelAdmin):
    list_display = ('name', 'image','text') # указываем названия полей как в модели
# Register your models here.
