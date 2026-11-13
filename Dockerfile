# Imagen oficial liviana de Nginx; servir archivos estáticos sin backend.
FROM nginx:alpine

# Eliminar contenido predeterminado y copiar la página estática.
RUN rm -rf /usr/share/nginx/html/*
COPY src/ /usr/share/nginx/html/

# Documenta el puerto del servidor en el contenedor.
EXPOSE 80
