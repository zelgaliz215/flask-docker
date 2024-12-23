FROM alpine:3.20

# Instalar Python y pip
RUN apk add --no-cache python3 py3-pip py3-virtualenv

# Establece el directorio de trabajo en el contenedor como  /app#, es decir en la raiz del contenedor 
WORKDIR /app

# Copiar la carpeta de la aplicacion (src) al directorio de trabajo del contenedor (/app/src) para que se cree la misma estructura
COPY . /app

# Crear un entorno virtual en la rais de la aplicacion /app/venv puede ser env
RUN python3 -m venv env

# Activa el entorno virtual (source venv/bin/activate) e instala las dependencias (pip install --no-cache-dir -r src/requirements.txt)
RUN source env/bin/activate && pip install --no-cache-dir -r src/requirements.txt

# Expone el puerto para Flask # este debe ser mapeado en el  app.run>  app.run(debug=True, host="0.0.0.0", port=5000)
EXPOSE 5000

# Usa el entorno virtual para ejecutar la aplicación (se ejecuta con la shell sh y la lista de comandos que activan el entorno y ejecutan el archivo de la app)
CMD ["sh", "-c", "source env/bin/activate && python src/app.py"]

# Crear la imagen

# docker build -t flask-docker-img .
# docker run --rm -p 5000:5000 flask-docker-img