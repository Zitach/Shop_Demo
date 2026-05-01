FROM dart:3.6 AS build

WORKDIR /app

COPY pubspec.yaml pubspec.lock ./
RUN dart pub get

COPY . .

RUN dart_frog build

FROM dart:3.6-runtime

WORKDIR /app

COPY --from=build /app/build/bin/server /app/server

EXPOSE 8080

CMD ["/app/server"]
