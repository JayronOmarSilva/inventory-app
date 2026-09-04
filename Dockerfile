### Dockerfile para la aplicación de Flask en Python
### Usa una imagen base liviana
FROM python:3.9-slim-buster as base

### Configura las variables de entorno
ENV PYTHONUNBUFFERED 1
ENV FLASK_APP app.py
ENV PORT 8080

### Crea el directorio de la app
WORKDIR /app

### Instala las dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn

### Copia el código de la aplicación
COPY . .

### Comando para ejecutar la aplicación con Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"] # 'app:app' supone que la app de Flask se llama 'app' en 'app.py'

### Verificación de estado (opcional, pero se recomienda)
HEALTHCHECK CMD curl --fail http://localhost:8080/products/SKU001 || exit 1
