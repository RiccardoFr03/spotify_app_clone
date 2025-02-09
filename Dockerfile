# Dockerfile for Flutter Web
FROM ghcr.io/cirruslabs/flutter:3.27.1 AS build

WORKDIR /app

COPY . .

RUN flutter pub get

#RUN flutter build web --release
RUN flutter build web --release --web-renderer html

FROM nginx:stable-alpine
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]