FROM harbor.meda.test/network-service/flutter-demo-app-test:latest as build-stage

WORKDIR /app

RUN flutter build web

FROM nginx:stable-alpine as production-stage
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build-stage /app/build/web /usr/share/nginx/html/flutter

EXPOSE 80
CMD ["nginx","-g","daemon off;"]