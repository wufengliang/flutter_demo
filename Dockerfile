FROM harbor.meda.test/network-service/flutter-demo-app-test:latest as build-stage

WORKDIR /app

RUN flutter build web

FROM nginx:stable-alpine as production-stage

COPY --from=build-stage /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx","-g","daemon off;"]