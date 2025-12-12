from django.shortcuts import render
from .models import Product
def catalog(request):
    product = Product.objects.all()
    return render(request, 'smile/index.html', {'product': product}) 
# Create your views here.
